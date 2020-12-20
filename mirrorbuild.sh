mkdir -p $GNUPGHOME
mkdir -p $dm_outPath
gpg --no-default-keyring --keyring ${GNUPGHOME}/trustedkeys.gpg --import /usr/share/keyrings/ubuntu-archive-keyring.gpg

debmirror       -a $dm_arch \
                --no-source \
                -s $dm_section \
                -h $dm_server \
                -d $dm_release \
                -r $dm_inPath \
                --progress \
                --method=$dm_proto \
                $dm_outPath

