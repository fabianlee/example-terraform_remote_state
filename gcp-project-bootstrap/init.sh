
[ -n "$TF_VAR_project" ] || { echo "ERROR you need to define env var 'TF_VAR_project' first"; exit 1; }

echo "IMPORTANT: Make sure you have run this gcloud auth command:"
echo "gcloud auth application-default login --project $TF_VAR_project"
echo ""

terraform init --upgrade
