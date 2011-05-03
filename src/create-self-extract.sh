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
mkdir payload

# Create dummy script
cat > payload/main.sh << EOF
#!/bin/bash
echo "Main"
echo "Hello world!"
echo "Args: \$*"
EOF
chmod u+x payload/main.sh

# Create decompress script
cat > decompress << EOF
#!/bin/bash
echo ""
echo "Self Extracting Installer"
echo ""

export TMPDIR=\`mktemp -d /tmp/selfextract.XXXXXX\`

ARCHIVE=\`awk '/^__ARCHIVE_BELOW__/ {print NR + 1; exit 0; }' \$0\`

tail -n+\$ARCHIVE \$0 | tar xzv -C \$TMPDIR

CDIR=\`pwd\`
cd \$TMPDIR
./main.sh \$* > >(tee \$CDIR/\$0.\$\$.out) 2> >(tee \$CDIR/\$0.\$\$.err >&2)


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
        cat decompress payload.tar.gz > $MY_PROJECT.bsx
        chmod u+x $MY_PROJECT.bsx
    else
        echo "payload.tar.gz does not exist"
        exit 1
    fi
else
    echo "payload.tar does not exist"
    exit 1
fi

echo "$MY_PROJECT.bsx created"
exit 0
EOF
chmod u+x build
