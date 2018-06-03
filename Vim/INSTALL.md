# Vim install notes

## pathogen

### Gvim on Windows

```
mkdir -p $USERPROFILE/vimfiles/autoload $USERPROFILE/vimfiles/bundle && \
curl -LSso $USERPROFILE/vimfiles/autoload/pathogen.vim https://tpo.pe/pathogen.vim
```

### Rest of the world incl. Cygwin

```
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
```

## ale 

### Gvim on Windows 

```
cd $USERPROFILE/vimfiles/bundle/
git clone https://github.com/w0rp/ale.git
```

### Rest of the world incl. Cygwin

```
git clone https://github.com/w0rp/ale.git ~/.vim/bundle/ale
```

## lightline.vim

### Gvim on Windows 

```
cd $USERPROFILE/vimfiles/bundle/
git clone https://github.com/itchyny/lightline.vim
```

### Rest of the world incl. Cygwin

```
git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline.vim
```

## Vim Outliner

### Gvim on Windows 

```
cd $USERPROFILE/vimfiles/bundle/
git clone https://github.com/vimoutliner/vimoutliner
```

### Rest of the world incl. Cygwin

```
git clone https://github.com/vimoutliner/vimoutliner ~/.vim/bundle/vimoutliner.vim
```

[modeline]: # ( vim: set fenc=utf-8 textwidth=78 formatoptions=tn: ) 
