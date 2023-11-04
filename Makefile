## makefile 0.4
#オブジェクトファイル生成は保留 debugの指定もなんか変だが。

# コンパイラ
CC = c++

# コンパイルオプション
CFLAGS = -std=c++17 -Wall --pedantic-errors
#clang_options = -std=c++17 -Wall --pedantic-errors

#実行ファイル名
TARGET = program
#TARGET = myProject

#ソースコード
SRCS = main.cpp
#SRCS += flow.cpp

# オブジェクトファイル名
OBJS = $(SRCS:.cpp=.o)

#インクルードファイルのデレクトリーパス
#INCDIR = -I./include

#ライブラリのパス
LIBDIR =
#LIBDIR = #-L/usr/local

#追加ライブラリfile
LIBS =
#LIBS = #-lprocps

#ヘッダファイル
HEADER = all.h

#mkdir
#$(mkdir ./src ./bin ./include ./obj )

#走査パス指定
vpath %.cpp src
vpath %.o bin
vpath %.h include

#ヘッダファイルのコンパイル
$(HEADER).gch : $(HEADER)
#c++ $(clang_options) -x c++-header -o $@ $<
	$(CC) $(CFLAGS) -x c++-header -o $@ $<

# #オブジェクトファイル生成
# $(OBJS): $(SRCS)
# 	$(CC) $(CFLAGS) $(INCDIR) $(HEADER).gch -c $< $(SRCS)

#ターゲットファイルの生成
$(TARGET):	$(SRCS) $(HEADER) $(HEADER).gch
	 #$(CC) $(CFLAGS)-o $@ $^ $(LIBDIR) $(LIBS)
	$(CC) $(CFLAGS) -include $(HEADER) $< -o $@

#同時実施
all:	clean $(OBJS) $(TARGET)

#ｄｅｂａｇｕ
dbug:
#$(CC) $(CFLAGS) -include ./include/$(HEADER) ./src/$(SRCS) -g
	$(CC) $(CFLAGS) -include ./include/$(HEADER) ./src/$(SRCS) -g0 -g
	-gdb ./a.out

echo:
	@echo "--** ECHO **--"

#クリーンアップ
clean:
	-rm -f $(OBJS) $(TARGET) *.d
	-rm -f  $(HEADER).gch

#run
run:	$(TARGET)
	-mv ./$(TARGET) ./bin/
	./bin/$(TARGET)

.PHONY : run clean mk dbug echo


################################
# program	: main.cpp all.h all.h.gch
# 	c++ $(clang_options) -include all.h $< -o $@

# all.h.gch : all.h
# 	c++ $(clang_options) -x c++-header -o $@ $<

# run : program
# 	./program

# clean :
# 	rm -f ./program
# 	rm -f ./all.h.gch

# .PHONY : run clean
