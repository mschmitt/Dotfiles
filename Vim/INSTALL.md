# Vim install notes

## Gvim on Windows

```
# Pathogen
mkdir -p $USERPROFILE/vimfiles/autoload $USERPROFILE/vimfiles/bundle && \
curl -LSso $USERPROFILE/vimfiles/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Ale
cd $USERPROFILE/vimfiles/bundle/
git clone https://github.com/w0rp/ale.git

# Lightline
cd $USERPROFILE/vimfiles/bundle/
git clone https://github.com/itchyny/lightline.vim

# Vim Outliner
cd $USERPROFILE/vimfiles/bundle/
git clone https://github.com/vimoutliner/vimoutliner

# Vim Indentline
cd $USERPROFILE/vimfiles/bundle/
git clone https://github.com/yggdroot/indentline

# Vim Yaml folds
cd $USERPROFILE/vimfiles/bundle/
git clone https://github.com/pedrohdz/vim-yaml-folds
```

## Rest of the world incl. Cygwin

```
# Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Ale
git clone https://github.com/w0rp/ale.git ~/.vim/bundle/ale

# Lightline
git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline.vim

# Vim Outliner
git clone https://github.com/vimoutliner/vimoutliner ~/.vim/bundle/vimoutliner.vim

# Vim Indentline
git clone https://github.com/yggdroot/indentline ~/.vim/bundle/indentline

# Vim Yaml folds
git clone https://github.com/pedrohdz/vim-yaml-folds ~/.vim/bundle/vim-yaml-folds
```

[modeline]: # ( vim: set fenc=utf-8 textwidth=78 formatoptions=tn: ) 
