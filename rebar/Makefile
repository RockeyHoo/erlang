# ==========================================================================
# Makefile 详解
#   Makefile中的命令必须以[Tab]键开始
#   变量定义与linux一样，变量名大写，可以通过$(VAR)引用，方法的调用也是通过$(),eg:$(PWD)
#   @ 的作用是抑制输出
#   规则表达式
#       目标: 依赖(多个空格隔开)
#       [Tab]命令
# ==========================================================================

#  伪目标文件 避免和同名文件冲突
.PHONY: clean dialyzer_warnings xref_warnings deps test

# 定义两个变量
REBAR=$(PWD)/rebar
RETEST=$(PWD)/deps/retest/retest

# 编译主入口
all:
	./bootstrap

# 清理编译结果
clean:
	@rm -rf rebar ebin/*.beam inttest/rt.work rt.work .eunit

distclean: clean
	@rm -f dialyzer_warnings
	@rm -rf deps

debug:
	@./bootstrap debug

check: debug xref dialyzer deps test

xref:
	@./rebar xref

dialyzer: dialyzer_warnings
	@diff -U0 dialyzer_reference dialyzer_warnings

dialyzer_warnings:
	-@dialyzer -q -nn -n ebin -Wunmatched_returns -Werror_handling \
		-Wrace_conditions > dialyzer_warnings

binary: VSN = $(shell ./rebar -V)
binary: clean all
	@cp rebar ../rebar.wiki/rebar
	(cd ../rebar.wiki && git commit -m "Update $(VSN)" rebar)

deps:
	@REBAR_EXTRA_DEPS=1 ./rebar get-deps
	@(cd deps/retest && $(REBAR) compile escriptize)

test:
	@$(REBAR) eunit
	@$(RETEST) -v inttest

travis: clean debug xref clean all deps test
