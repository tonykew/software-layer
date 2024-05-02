export MODULESHOME=${EPREFIX}/usr/share/Lmod
source ${MODULESHOME}/init/profile
export LMOD_PACKAGE_PATH=${CCR_INIT_DIR}/lmod
export LMOD_ADMIN_FILE=${CCR_INIT_DIR}/lmod/admin.list
export LMOD_AVAIL_STYLE=grouped:system
export LMOD_AVAIL_EXTENSIONS=no
export LMOD_RC=${LMOD_PACKAGE_PATH}/lmodrc.lua
export LMOD_SHORT_TIME=3600

if [[ -z "$__Init_Default_Modules" ]]; then
    if [[ -z "$MODULERCFILE" ]]; then
        MODULERCFILE=${LMOD_PACKAGE_PATH}/modulerc_${CCR_VERSION}.lua:${LMOD_PACKAGE_PATH}/modulerc.lua
    else
        MODULERCFILE=$MODULERCFILE:${LMOD_PACKAGE_PATH}/modulerc_${CCR_VERSION}.lua:${LMOD_PACKAGE_PATH}/modulerc.lua
    fi
    export MODULERCFILE=$MODULERCFILE

    export MODULEPATH=${CCR_INIT_DIR}/modulefiles
    __Init_Default_Modules=1; export __Init_Default_Modules;
    if [[ -z "$LMOD_SYSTEM_DEFAULT_MODULES" ]]; then
        export LMOD_SYSTEM_DEFAULT_MODULES="ccrsoft"
    fi
    if [[ $- == *i* ]]; then
        module --initial_load restore
    else
        module -q --initial_load restore
    fi
else
    module -q --initial_load restore
fi
