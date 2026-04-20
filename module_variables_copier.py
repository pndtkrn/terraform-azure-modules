import re
import os
import argparse

MODULE_PATH = "modules"
ROOT_VARIABLE_FILE = "variables.tf"
ROOT_TFVARS_FILE = "terraform.tfvars"


def extract_module_variables(module_variable_file_path: str) -> dict:
    # Read the module variable file content
    with open(module_variable_file_path, 'r') as file:
        content = file.read()

    # Regex pattern to match variable blocks
    pattern = r'variable\s+"([^"]+)"\s*{([^{}]*({[^{}]*})*[^{}]*)}'

    # Find all variable blocks in the content
    matches = re.findall(pattern, content, re.DOTALL)
    
    # Store variables in a dictionary
    variables = {}
    for match in matches:
        var_name = match[0]
        var_body = match[1]
        variables[var_name] = var_body.strip()
    
    # Return the dictionary of variables
    return variables


def get_variable_files_list(module_path: str):
    module_variable_file = "variables.tf"
    all_modules = os.listdir(module_path)
    
    module_variable_file_paths = []
    # Iterate through all modules to find variable files
    for module in all_modules:
        # Check if it's a directory or a single file
        if os.path.isdir(os.path.join(module_path, module)):
            if os.path.isfile(os.path.join(module_path, module, module_variable_file)):
                module_variable_file_paths.append({module: os.path.join(module_path, module, module_variable_file)})
        # Handle case where module_path directly contains variable files
        elif os.path.isfile(os.path.join(module_path, module)):
            if module == module_variable_file:
                module_variable_file_paths.append({os.path.basename(os.path.normpath(module_path)): os.path.join(module_path, module_variable_file)})
    
    # Return list of module variable file paths
    return module_variable_file_paths


def copy_module_variables_to_root(module_path: str, root_variable_file: str, root_tfvars_file: str, overwrite_tfvars: bool = False):
    root_module_variables = {}
    all_variable_names = []

    # Get all module variable file paths
    module_variable_file_paths = get_variable_files_list(module_path)
    # Extract variables from each module
    for data in module_variable_file_paths:
        for module_name, variable_file_path in data.items():
            module_variables = extract_module_variables(variable_file_path)
            # Keep track of all variable names for duplicate detection
            all_variable_names.append(list(module_variables.keys()))
            # Store module variables
            root_module_variables[module_name] = module_variables

    # Remove duplicate variables across modules
    if len(all_variable_names) > 1:
        duplicate_variables = set(all_variable_names[0]).intersection(*all_variable_names[1:])
        global_variables = {}
        for module, variables in root_module_variables.items():
            for dup_var in duplicate_variables:
                if dup_var in variables:
                    global_variables[dup_var] = variables[dup_var]
                    del variables[dup_var]
    
        # Add global variables at the top of the root variable dict
        if global_variables:
            root_module_variables = {"global": global_variables, **root_module_variables}
    
    # Read existing tfvars file contents
    existing_tfvars = {}
    if os.path.isfile(root_tfvars_file):
        with open(root_tfvars_file, 'r') as tfvars_file:
            for line in tfvars_file:
                if '=' in line and line.split('=')[1].strip() != 'null':
                    var_name = line.split('=')[0].strip()
                    var_value = line.split('=')[1].strip()
                    existing_tfvars[var_name] = var_value


    # Write the variables to the root variable file and tfvars file
    with open(root_variable_file, 'w') as var_file, open(root_tfvars_file, 'a') as tfvars_file:
        if overwrite_tfvars:
            tfvars_file.truncate(0)
        for module, variables in root_module_variables.items():
            if module == "global":
                var_file.write(f"# Global Variables\n")
                if overwrite_tfvars:
                    tfvars_file.write(f"# Global Variables\n")
            else:
                var_file.write(f"# Variables from module: {module}\n")
                if overwrite_tfvars:
                    tfvars_file.write(f"# Variables from module: {module}\n")
            for var_name, var_body in variables.items():
                # Write to variable file
                var_file.write(f'variable "{var_name}" {{\n{var_body}\n}}\n\n')
                # Write to tfvars file, using existing value if available
                if overwrite_tfvars:
                    if var_name in existing_tfvars:
                        tfvars_file.write(f'{var_name} = {existing_tfvars[var_name]}\n')
                    else:
                        tfvars_file.write(f'{var_name} = null\n')
    
    # Write a summary of copied variables
    print("Copied the following variables to the root variable file:")
    for module, variables in root_module_variables.items():
        print(f"Module: {module}")
        for var_name in variables.keys():
            print(f"  - {var_name}")


if __name__ == "__main__":
    argparser = argparse.ArgumentParser(description="Copy module variables to root variable file.")
    argparser.add_argument("--module-path", type=str, default=MODULE_PATH, help="Path to the modules directory.")
    argparser.add_argument("--root-variable-file", type=str, default=ROOT_VARIABLE_FILE, help="Path to the root variable file.")
    argparser.add_argument("--root-tfvars-file", type=str, default=ROOT_TFVARS_FILE, help="Path to the root tfvars file.")
    argparser.add_argument("--overwrite-tfvars", action="store_true", help="Overwrite the root tfvars file if it exists.")
    args = argparser.parse_args()

    copy_module_variables_to_root(args.module_path, args.root_variable_file, args.root_tfvars_file, args.overwrite_tfvars)
