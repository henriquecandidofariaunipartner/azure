az upgrade --allow-preview-extensions true --debug 
# --allow-preview-extensions false
az config set core.allow_broker=false --debug
az account clear --debug
az config set core.enable_broker_on_windows=false
az login --tenant  --debug