# nimls

lsコマンドをNimで実装してみる．


## ロジック

1.パスを取得 : `cmdArgument`

2.パスが存在するか確認 : `fileExists("path")`, `dirExists("path")`

	a.しない :
		
		`quit(QuitFailure)`

	b.する :
	
		`continue`

3.オプションが有るか確認 : `cmdShortOption`, `cmdLongOption`

	a.ない :
		
		隠しを除くファイル，ディレクトリを取得 : `walkDir(path)`, `string.startWith("/.")`, `string.contains("/.")`

	b.ある :
		
		`-?, --help` : nimlsのドキュメント表示

		`-a, --all` : 隠しを含むファイル，ディレクトリを取得 : `walkDir(path)`
		
		`-d, --dir` : ディレクトリを取得 : pcDir
		
		`-f, --file` : ファイルを取得 : pcFile
		
		`-r, --recurse` : ファイル，ディレクトリを再帰的に取得 : `walkDirRec(path)` -> `walkDir(path)`の再帰

		

4.取得したファイル，ディレクトリを表示

正確には対象以下にあるパスを `-r` プションに従い取得し，`-a`, `-d`, `-f`, オプションでフィルタリング．

フィルタイング語のパスリストを表示している．

~~lsコマンドと同等以上の速さにするならこのロジックは崩したほうがいい．~~

-> リリースビルドを行うことにより，同等以上の速度を計測できた．

-> 今後オプションを増やすなら，ロジックの変更をしたほうがいい予感．


## 今後のToDo

- [ ] `-p, --permission` : ファイル，ディレクトリのパーミッションの取得 -> getFilePermission(filename)

- [ ] `-t, --time` : ファイル，ディレクトリの日時関連の取得 -> getCreationTime(path), getLastAccessTime(path), getLastModificationTime(path)

- [ ] `-s, --size` : ファイルサイズの取得 -> getFileSize(path)

- [ ] `-i, --info` : ファイル，ディレクトリの詳細情報の取得 -> getFileInfo(path), FileInfo object

- [ ] `-l, --link` : リンクファイル，リンクディレクトリの取得 -> pcLinkToFile, pcLinkToDir


## 余談

Markdownってこんなに書きにくかったかな？
