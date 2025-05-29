LOCALSTACK_COMPOSE_FILE="submodules/LocalstackSetup/docker-compose.localstack.yml"

if [ -f "$LOCALSTACK_COMPOSE_FILE" ]; then
  if declare -p upFiles &>/dev/null; then
    upFiles+=("$LOCALSTACK_COMPOSE_FILE")
  fi
  if declare -p downFiles &>/dev/null; then
    downFiles+=("$LOCALSTACK_COMPOSE_FILE")
  fi
  if declare -p nukeFiles &>/dev/null; then
    nukeFiles+=("$LOCALSTACK_COMPOSE_FILE")
  fi
  if declare -p nukeSharedFiles &>/dev/null; then
    nukeSharedFiles+=("$LOCALSTACK_COMPOSE_FILE")
  fi
fi

if [ "$1" = "deploy" ]; then
  if [ -z "$PROJECT_NAME" ] || [ -z "$PROJECT_DIR" ] || [ -z "$TERRAFORM_DIR" ]; then
    echo "PROJECT_NAME and PROJECT_DIR and TERRAFORM_DIR must be set before calling deploy."
    exit 1
  fi

  OUTPUT_DIR="build/$PROJECT_NAME"
  ORIG_DIR="$(pwd)"
  echo "Building Lambda project..."
  dotnet publish "$PROJECT_DIR" -c Release -o "$OUTPUT_DIR"

  echo "Zipping Lambda..."
  cd "$OUTPUT_DIR" || exit 1
  zip -r lambda.zip .

  echo "Deploying with Terraform..."
  cd "$ORIG_DIR" || exit 1
  cd "$TERRAFORM_DIR" || exit 1
  terraform apply -auto-approve
fi
