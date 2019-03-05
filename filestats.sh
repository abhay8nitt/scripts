#!/bin/bash
FILENAME="/path/to/your/file"

USER=$(stat -c '%U' $FILENAME)
echo "User <$USER> accessed $FILENAME>

GROUP=$(stat -c '%G' /path/to/your/file)
echo "Group <$GROUP> of the $FILENAME>
