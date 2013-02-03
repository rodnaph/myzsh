
# scm_breeze location
SCMB="$HOME/.scm_breeze"

# setup scm_breeze
if [ ! -e $SCMB ];
then
    scmbDir=$SCMB

    echo "'SCM Breeze' not found, installing..."
    git clone git://github.com/ndbroadbent/scm_breeze.git $SCMB

    source "$SCMB/lib/scm_breeze.sh"

    _create_or_patch_scmbrc
fi

# load scm_breeze
source "$SCMB/scm_breeze.sh"

