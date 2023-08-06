echo "IMPORTANT: Make sure you have run this gcloud auth command:"
echo "gcloud auth application-default login --project $TF_VAR_project"
echo ""

terraform init -backend-config=../dynamic-backend.hcl
if [ $? -ne 0 ]; then
  echo "WARN tf init failed, try using migrate-state to resolve..."
  terraform init --migrate-state -backend-config=../dynamic-backend.hcl
fi
