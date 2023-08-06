terraform init -backend-config=../dynamic-backend.hcl
if [ $? -ne 0 ]; then
  echo "WARN tf init failed, try using migrate-state to resolve..."
  terraform init --migrate-state -backend-config=../dynamic-backend.hcl
fi
