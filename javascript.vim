" Vim syntax file
" Language:	JavaScript
" Maintainer:	Claudio Fleiner <claudio@fleiner.com>
" Updaters:	Scott Shattuck (ss) <ss@technicalpursuit.com>
" URL:		http://www.fleiner.com/vim/syntax/javascript.vim
" Changes:	(ss) added keywords, reserved words, and other identifiers
"		(ss) repaired several quoting and grouping glitches
"		(ss) fixed regex parsing issue with multiple qualifiers [gi]
"		(ss) additional factoring of keywords, globals, and members
" Last Change:	2020 May 14
" 		2013 Jun 12: adjusted javaScriptRegexpString (Kevin Locke)
" 		2018 Apr 14: adjusted javaScriptRegexpString (LongJohnCoder)

" tuning parameters:
" unlet javaScript_fold

if !exists("main_syntax")
  " quit when a syntax file was already loaded
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
elseif exists("b:current_syntax") && b:current_syntax == "javascript"
  finish
endif

let s:cpo_save = &cpo
set cpo&vim


syn keyword javaScriptCommentTodo      TODO FIXME XXX TBD contained
syn match   javaScriptLineComment      "\/\/.*" contains=@Spell,javaScriptCommentTodo
syn match   javaScriptCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn region  javaScriptComment	       start="/\*"  end="\*/" contains=@Spell,javaScriptCommentTodo
syn match   javaScriptSpecial	       "\\\d\d\d\|\\."
syn region  javaScriptStringD	       start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=javaScriptSpecial,@htmlPreproc
syn region  javaScriptStringS	       start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=javaScriptSpecial,@htmlPreproc
syn region  javaScriptStringT	       start=+`+  skip=+\\\\\|\\`+  end=+`+	contains=javaScriptSpecial,javaScriptEmbed,@htmlPreproc

syn region  javaScriptEmbed	       start=+${+  end=+}+	contains=@javaScriptEmbededExpr

syn match   javaScriptSpecialCharacter "'\\.'"
syn match   javaScriptNumber	       "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region  javaScriptRegexpString     start=+[,(=+]\s*/[^/*]+ms=e-1,me=e-1 skip=+\\\\\|\\/+ end=+/[gimuys]\{0,2\}\s*$+ end=+/[gimuys]\{0,2\}\s*[+;.,)\]}]+me=e-1 end=+/[gimuys]\{0,2\}\s\+\/+me=e-1 contains=@htmlPreproc,javaScriptComment oneline

syn keyword javaScriptConditional	if else switch
syn keyword javaScriptRepeat		while for do in
syn keyword javaScriptBranch		break continue
syn keyword javaScriptOperator		new delete instanceof typeof
syn keyword javaScriptType		Array Boolean Date Function Number Object String RegExp
syn keyword javaScriptStatement		return with await
syn keyword javaScriptBoolean		true false
syn keyword javaScriptNull		null undefined
syn keyword javaScriptIdentifier	arguments this var let
syn keyword javaScriptLabel		case default
syn keyword javaScriptException		try catch finally throw
syn keyword javaScriptMessage		alert confirm prompt status
syn keyword javaScriptGlobal		self window top parent
syn keyword javaScriptMember		document event location 
syn keyword javaScriptDeprecated	escape unescape
syn keyword javaScriptReserved		abstract boolean byte char class const debugger double enum export extends final float goto implements import int interface long native package private protected public short static super synchronized throws transient volatile async

syn cluster  javaScriptEmbededExpr	contains=javaScriptBoolean,javaScriptNull,javaScriptIdentifier,javaScriptStringD,javaScriptStringS,javaScriptStringT

if exists("javaScript_fold")
    syn match	javaScriptFunction	"\<function\>"
    syn region	javaScriptFunctionFold	start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match javaScriptSync	grouphere javaScriptFunctionFold "\<function\>"
    syn sync match javaScriptSync	grouphere NONE "^}"

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
else
    syn keyword javaScriptFunction	function
    syn match	javaScriptBraces	   "[{}\[\]]"
    syn match	javaScriptParens	   "[()]"
endif

if main_syntax == "javascript"
  syn sync fromstart
  syn sync maxlines=100

  syn sync ccomment javaScriptComment
endif

" Define the default highlighting.
" Only when an item doesn't have highlighting yet
hi def link javaScriptComment		Comment
hi def link javaScriptLineComment		Comment
hi def link javaScriptCommentTodo		Todo
hi def link javaScriptSpecial		Special
hi def link javaScriptStringS		String
hi def link javaScriptStringD		String
hi def link javaScriptStringT		String
hi def link javaScriptCharacter		Character
hi def link javaScriptSpecialCharacter	javaScriptSpecial
hi def link javaScriptNumber		javaScriptValue
hi def link javaScriptConditional		Conditional
hi def link javaScriptRepeat		Repeat
hi def link javaScriptBranch		Conditional
hi def link javaScriptOperator		Operator
hi def link javaScriptType			Type
hi def link javaScriptStatement		Statement
hi def link javaScriptFunction		Function
hi def link javaScriptBraces		Function
hi def link javaScriptError		Error
hi def link javaScrParenError		javaScriptError
hi def link javaScriptNull			Keyword
hi def link javaScriptBoolean		Boolean
hi def link javaScriptRegexpString		String

hi def link javaScriptIdentifier		Identifier
hi def link javaScriptLabel		Label
hi def link javaScriptException		Exception
hi def link javaScriptMessage		Keyword
hi def link javaScriptGlobal		Keyword
hi def link javaScriptMember		Keyword
hi def link javaScriptDeprecated		Exception 
hi def link javaScriptReserved		Keyword
hi def link javaScriptDebug		Debug
hi def link javaScriptConstant		Label
hi def link javaScriptEmbed		Special

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syn case ignore

" mark illegal characters
syn match htmlError "[<>&]"


" tags
syn region  htmlString   contained start=+"+ end=+"+ contains=htmlSpecialChar,javaScriptExpression,@htmlPreproc
syn region  htmlString   contained start=+'+ end=+'+ contains=htmlSpecialChar,javaScriptExpression,@htmlPreproc
syn match   htmlValue    contained "=[\t ]*[^'" \t>][^ \t>]*"hs=s+1   contains=javaScriptExpression,@htmlPreproc
syn region  htmlEndTag             start=+</+      end=+>+ contains=htmlTagN,htmlTagError
syn region  htmlTag                start=+<[^/]+   end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster
syn match   htmlTagN     contained +<\s*[-a-zA-Z0-9]\++hs=s+1 contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster
syn match   htmlTagN     contained +</\s*[-a-zA-Z0-9]\++hs=s+2 contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster
syn match   htmlTagError contained "[^>]<"ms=s+1


" tag names
syn keyword htmlTagName contained address applet area a base basefont
syn keyword htmlTagName contained big blockquote br caption center
syn keyword htmlTagName contained cite code dd dfn dir div dl dt font
syn keyword htmlTagName contained form hr html img
syn keyword htmlTagName contained input isindex kbd li link map menu
syn keyword htmlTagName contained meta ol option param pre p samp span
syn keyword htmlTagName contained select small sub sup
syn keyword htmlTagName contained table td textarea th tr tt ul var xmp
syn match htmlTagName contained "\<\(b\|i\|u\|h[1-6]\|em\|strong\|head\|body\|title\)\>"

" new html 4.0 tags
syn keyword htmlTagName contained abbr acronym bdo button col label
syn keyword htmlTagName contained colgroup fieldset iframe ins legend
syn keyword htmlTagName contained object optgroup q s tbody tfoot thead

" new html 5 tags
syn keyword htmlTagName contained article aside audio bdi canvas data
syn keyword htmlTagName contained datalist details dialog embed figcaption
syn keyword htmlTagName contained figure footer header hgroup keygen main
syn keyword htmlTagName contained mark menuitem meter nav output picture
syn keyword htmlTagName contained progress rb rp rt rtc ruby section
syn keyword htmlTagName contained slot source summary template time track
syn keyword htmlTagName contained video wbr

" legal arg names
syn keyword htmlArg contained action
syn keyword htmlArg contained align alink alt archive background bgcolor
syn keyword htmlArg contained border bordercolor cellpadding
syn keyword htmlArg contained cellspacing checked class clear code codebase color
syn keyword htmlArg contained cols colspan content coords enctype face
syn keyword htmlArg contained gutter height hspace id
syn keyword htmlArg contained link lowsrc marginheight
syn keyword htmlArg contained marginwidth maxlength method name prompt
syn keyword htmlArg contained rel rev rows rowspan scrolling selected shape
syn keyword htmlArg contained size src start target text type url
syn keyword htmlArg contained usemap ismap valign value vlink vspace width wrap
syn match   htmlArg contained "\<\(http-equiv\|href\|title\)="me=e-1

" aria attributes
syn match htmlArg contained "\<\(aria-activedescendant\|aria-atomic\)\>"
syn match htmlArg contained "\<\(aria-autocomplete\|aria-busy\|aria-checked\)\>"
syn match htmlArg contained "\<\(aria-colcount\|aria-colindex\|aria-colspan\)\>"
syn match htmlArg contained "\<\(aria-controls\|aria-current\)\>"
syn match htmlArg contained "\<\(aria-describedby\|aria-details\)\>"
syn match htmlArg contained "\<\(aria-disabled\|aria-dropeffect\)\>"
syn match htmlArg contained "\<\(aria-errormessage\|aria-expanded\)\>"
syn match htmlArg contained "\<\(aria-flowto\|aria-grabbed\|aria-haspopup\)\>"
syn match htmlArg contained "\<\(aria-hidden\|aria-invalid\)\>"
syn match htmlArg contained "\<\(aria-keyshortcuts\|aria-label\)\>"
syn match htmlArg contained "\<\(aria-labelledby\|aria-level\|aria-live\)\>"
syn match htmlArg contained "\<\(aria-modal\|aria-multiline\)\>"
syn match htmlArg contained "\<\(aria-multiselectable\|aria-orientation\)\>"
syn match htmlArg contained "\<\(aria-owns\|aria-placeholder\|aria-posinset\)\>"
syn match htmlArg contained "\<\(aria-pressed\|aria-readonly\|aria-relevant\)\>"
syn match htmlArg contained "\<\(aria-required\|aria-roledescription\)\>"
syn match htmlArg contained "\<\(aria-rowcount\|aria-rowindex\|aria-rowspan\)\>"
syn match htmlArg contained "\<\(aria-selected\|aria-setsize\|aria-sort\)\>"
syn match htmlArg contained "\<\(aria-valuemax\|aria-valuemin\)\>"
syn match htmlArg contained "\<\(aria-valuenow\|aria-valuetext\)\>"
syn keyword htmlArg contained role

" Netscape extensions
syn keyword htmlTagName contained frame noframes frameset nobr blink
syn keyword htmlTagName contained layer ilayer nolayer spacer
syn keyword htmlArg     contained frameborder noresize pagex pagey above below
syn keyword htmlArg     contained left top visibility clip id noshade
syn match   htmlArg     contained "\<z-index\>"

" Microsoft extensions
syn keyword htmlTagName contained marquee

" html 4.0 arg names
syn match   htmlArg contained "\<\(accept-charset\|label\)\>"
syn keyword htmlArg contained abbr accept accesskey axis char charoff charset
syn keyword htmlArg contained cite classid codetype compact data datetime
syn keyword htmlArg contained declare defer dir disabled for frame
syn keyword htmlArg contained headers hreflang lang language longdesc
syn keyword htmlArg contained multiple nohref nowrap object profile readonly
syn keyword htmlArg contained rules scheme scope span standby style
syn keyword htmlArg contained summary tabindex valuetype version

" html 5 arg names
syn keyword htmlArg contained allowfullscreen async autocomplete autofocus
syn keyword htmlArg contained autoplay challenge contenteditable contextmenu
syn keyword htmlArg contained controls crossorigin default dirname download
syn keyword htmlArg contained draggable dropzone form formaction formenctype
syn keyword htmlArg contained formmethod formnovalidate formtarget hidden
syn keyword htmlArg contained high icon inputmode keytype kind list loop low
syn keyword htmlArg contained max min minlength muted nonce novalidate open
syn keyword htmlArg contained optimum pattern placeholder poster preload
syn keyword htmlArg contained radiogroup required reversed sandbox spellcheck
syn keyword htmlArg contained sizes srcset srcdoc srclang step title translate
syn keyword htmlArg contained typemustmatch

" special characters
syn match htmlSpecialChar "&#\=[0-9A-Za-z]\{1,8};"


hi def link htmlPreStmt            PreProc
hi def link htmlPreError           Error
hi def link htmlPreProc            PreProc
hi def link htmlPreAttr            String
hi def link htmlPreProcAttrName    PreProc
hi def link htmlPreProcAttrError   Error
hi def link htmlSpecial            Special
hi def link htmlSpecialChar        Special
hi def link htmlString             String
hi def link htmlStatement          Statement
hi def link htmlComment            Comment
hi def link htmlCommentPart        Comment
hi def link htmlValue              String
hi def link htmlCommentError       htmlError
hi def link htmlTagError           htmlError
hi def link htmlEvent              javaScript
hi def link htmlError              Error

hi def link javaScript             Special
hi def link javaScriptExpression   javaScript
hi def link htmlCssStyleComment    Comment
hi def link htmlCssDefinition      Special


""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""


let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
