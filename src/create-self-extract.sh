#!/bin/sh
# create-self-extract.sh
#
# Creates a self extract script project. Based on http://www.linuxjournal.com/node/1005818 by jeff.parent
#

# Test for project name
if [ "$1" = "" ]; then
  echo "Should provide project name"
  exit 1
fi
MY_PROJECT=$1

# Remove directory if already exists
if [ -e $MY_PROJECT ]; then
  echo "'$MY_PROJECT' exists already. removing it."
  rm -rf "$MY_PROJECT"
fi

# Create directory
mkdir $MY_PROJECT
cd $MY_PROJECT
mkdir -p payload/libs
if [ -e /tmp/bash-utils ]; then
  rm -rf /tmp/bash-utils
fi
git clone git://github.com/rahulsom/bash-utils.git /tmp/bash-utils
cp /tmp/bash-utils/src/* payload/libs
rm -rf /tmp/bash-utils

# Create dummy script
cat > payload/main.sh << EOF
#!/bin/bash -eu
. libs/logger.sh
. libs/colors.sh
. libs/tasks.sh

ANERR="\${ANESC}\${ANFG}\${ANR}\${ANEND}"
abort() {
  echo -e "\${ANERR}Script execution was aborted. See logs for more details.\${ANRESET}"
  exit 1
}
trap abort ERR

info  "Starting installer"
debug "Args: (\$#) '\$*'"
debug "UID: \$UID(\$(getent passwd \$UID| cut -d: -f1))"
debug "PID: \$\$"
echo -e "\${ANESC}\${ANBOL};\${ANBG}\${ANB}\${ANEND}Installing Application\${ANRESET}"
echo 
taskdef "Performing task XXX"
taskok

EOF
chmod u+x payload/main.sh

# Create decompress script
cat > decompress << EOF
#!/bin/bash
export TMPDIR=\`mktemp -d /tmp/selfextract.XXXXXX\`

ARCHIVE=\`awk '/^__ARCHIVE_BELOW__/ {print NR + 1; exit 0; }' \$0\`

tail -n+\$ARCHIVE \$0 | tar xz -C \$TMPDIR

CDIR=\`pwd\`
cd \$TMPDIR
export SX_DEBUG=\$(echo " \$* "| grep -c " \-\-debug ")
if [ \$SX_DEBUG = 0 ]; then
  ./main.sh \$* > >(tee \$CDIR/\$0.\$\$.out) 2> \$CDIR/\$0.\$\$.err
else
  ./main.sh \$* > >(tee \$CDIR/\$0.\$\$.out) 2> >(tee \$CDIR/\$0.\$\$.err >&2)
fi


cd \$CDIR
rm -rf \$TMPDIR

exit 0

__ARCHIVE_BELOW__
EOF

# Create build script
cat > build << EOF
#!/bin/bash
cd payload
tar cf ../payload.tar ./*
cd ..

if [ -e "payload.tar" ]; then
    gzip payload.tar

    if [ -e "payload.tar.gz" ]; then
        cat decompress payload.tar.gz > $MY_PROJECT
        chmod +x $MY_PROJECT
        rm payload.tar.gz
    else
        echo "payload.tar.gz does not exist"
        exit 1
    fi
else
    echo "payload.tar does not exist"
    exit 1
fi

echo "$MY_PROJECT created"
exit 0
EOF
chmod u+x build
