# repoTest
==================================================================================

Versionamento xls/xlsx

Faça o download do xdoc2txt relativa à arquitetura de seu windows em

http://ebstudio.info/home/xdoc2txt.html#download

extraia o arquivo compactado em algum diretório e encontre o arquivo 

xdoc2txt.exe

dentro da pasta extraída (para a versão 2.20 está dentro de 'command')

Adicione este caminho à variável de ambiente 'PATH':

na barra de procura do Windows digite 'variáveis de ambiente';

-na janela que abrir, clique em 'variáveis de ambiente';

-na caixa 'Variáveis do sistema' ache a variável PATH;

-clique em 'editar', 'novo' e insira o caminho para xdoc2txt.exe

No seu repositório git, edite o arquivo '.gitattribute' ou '.git/attribute' e insira as seguintes linhas:

*.xls	diff=xdoc2txt
*.xlsx	diff=xdoc2txt

Abra um terminal git, entre no diretório do repositório e ditige

git config diff.xdoc2txt.textconv xdoc2txt.exe

==================================================================================
