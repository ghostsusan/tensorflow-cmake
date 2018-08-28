TF_TYPE="cpu" # Change to "gpu" for GPU support


if [ -d "external" ]; then
  echo "skip download"
else
  mkdir -p external
  cd external
  curl -L "https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-${TF_TYPE}-$(go env GOOS)-x86_64-1.10.1.tar.gz" | tar -C . -xz
  cd ..
fi

TF_PATH=`realpath external/lib`


export LD_LIBRARY_PATH=${TF_PATH}:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${TF_PATH}:${LIBRARY_PATH}

go build inference_go.go

echo "you need to set the following paths:"
echo "export LD_LIBRARY_PATH=${TF_PATH}/:\${LD_LIBRARY_PATH}"

