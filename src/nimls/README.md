# nimls
lsコマンドをNimで実装してみる．

## ロジック
1.パスを取得 : cmdArgument

2.パスが存在するか確認 : os.fileExists("path"), os.dirExists("path")

  a.しない : quit(QuitFailure)

  b.する : next

3.オプションが有るか確認 : cmdShortOption, cmdLongOption

  a.ない :

    隠しを除くファイル，ディレクトリを取得 : `walkDir(path)`, `string.startWith("/.")`, `string.contains("/.")`

  b.ある :

    `-a, --all` : 隠しを含むファイル，ディレクトリを取得 : `walkDir(path)`

    `-d, --dir` : ディレクトリを取得

    `-f, --file` : ファイルを取得

    `-r, --recurse` : ファイル，ディレクトリを再帰的に取得 : `walkDirRec(path)` -> `walkDir(path)`の再帰

    `-?, --help` : nimlsのドキュメント表示

4.取得したファイル，ディレクトリを表示

正確には対象以下にあるパスを `-r` プションに従い取得し，`-a`, `-d`, `-f`, オプションでフィルタリング．

フィルタイング語のパスリストを表示している．

lsコマンドと同等以上の速さにするならこのロジックは崩したほうがいい．
