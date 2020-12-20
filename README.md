# docker-debmirror

Override the default vars or run with the default below.
Mount a volume to your data dir

    dm_arch=amd64
    dm_section=main,restricted,universe,multiverse
    dm_release=focal,focal-security,focal-updates
    dm_server=ae.archive.ubuntu.com
    dm_inPath=/ubuntu
    dm_proto=http
    dm_outPath=/data/Ubuntu

