if [[ "$LOAD_NON_SENSE" == 1 ]]; then
  function nonsense() {
    echo "nonsense. Should not be included."
  }
fi
