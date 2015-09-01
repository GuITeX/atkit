\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arstexnica}[2014/03/16 v0.7.3 Document class for Ars TeXnica]
\RequirePackage{guit}
\RequirePackage{currfile}
\RequirePackage{arsacro}
\RequirePackage{iftex}
\RequirePackage{etoolbox}
\newcommand\ArsTeXnicaError{\ClassError{arstexnica}{%
     \MessageBreak
     ***********************************************\MessageBreak
     Programma di compilazione non valido           \MessageBreak
     Invalid typesetting program                    \MessageBreak
     Premi H per maggiori informazioni              \MessageBreak
     Press H for further help                       \MessageBreak
      ***********************************************
  }{\MessageBreak
     **********************************************************\MessageBreak
     Questa classe lavora solo con pdfLaTeX, XeLaTeX o LuaLaTeX\MessageBreak
     This class works only with pdfLaTeX, XeLaTeX, or LuaLaTeX \MessageBreak
     Premi X per terminare -- Press X to exit                  \MessageBreak
     **********************************************************
   }}
\DeclareOption{draft}{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\DeclareOption{final}{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\DeclareOption{paper}{%
  \def\@pjp{paper}
  \AtEndOfClass{%
    \let\tableofcontents\relax
    \def\@openarticle{\openarticlehook}
    \def\@closearticle{\@makesig}
  }
}
\DeclareOption{journal}{%
  \def\@pjp{journal}
  \AtEndOfClass{%
    \def\ATtableofcontents{%
      \renewcommand{\contentsname}{}
      \onecolumn
      \settowidth{\arswidth}{\scalebox{7}{\Ars}}
      \vspace*{4cm}
      \begin{center}
      \parbox{\arswidth}{%
        \raggedleft
        \scalebox{7}{\Ars}\par
        \vspace{10pt}
        \ArsSubtitle}\par
        \vskip\baselineskip
        \IssueLine
      \end{center}
      \vskip4\baselineskip
      {\centering
      \begin{minipage}{\arswidth}
      \@oldtoc
      \end{minipage}\par
      }
      \vfill
%      {\noindent\LARGE Numero \AT@number\hfill \AT@month\ \AT@year}\par%\vskip\baselineskip
%      {\noindent\LARGE Stampato a Pisa, Italia, \hfill \guit\ \guittext}\par
      {\centering\LARGE \guittext\par}
      \thispagestyle{empty}
      \clearpage
      {\thispagestyle{empty}\cleardoublepage}
      }
    \newcommand*\l@title{\@dottedtocline{0}{0pt}{0pt}}
    \setcounter{tocdepth}{0}
    \def\@openarticle{%
      \openarticlehook
      \nobalance
      \refstepcounter{article}
      \@addtoreset{section}{article}
      \@addtoreset{figure}{article}
      \@addtoreset{table}{article}
      \@addtoreset{equation}{article}
      \@addtoreset{footnote}{article}
      \@addtoreset{author}{article}
      \edef\theauthorlist{}
      \edef\AT@authors@bibentry{}
      \renewcommand\thesection{\arabic{section}}
      \setlength\sigindent{.25\columnwidth}
      \edef\AT@init@page{\thepage}
      \immediate\write\AT@articlepath{\currfiledir\currfilebase}
    }
    \def\@closearticle{%
      \@makesig
      \edef\AT@end@page{\thepage}
      \AT@write@bibentry
    }
    \InputIfFileExists{\jobname.cfg}{%
      \@cfgfound}{\@cfgnotfound}
  }
  \AtBeginDocument{
    \openout\AT@lst=artlist.lst
    \openout\AT@articlepath=articlepath.lst
    \RequirePackage{arstestata}
  }
  \AtEndDocument{%
    \closeout\AT@lst
    \closeout\AT@articlepath
  }
}
\DeclareOption{standalone}{%
  \AtEndOfClass{%
    \def\@openarticle{}
    \def\@closearticle{\@makesig}
  \let\tableofcontents\@oldtoc
  }
  \def\@pjp{standalone}
}
\ExecuteOptions{draft,paper}
\ProcessOptions
\LoadClass[a4paper,twocolumn,twoside,10pt]{article}
\RequirePackage{dblfloatfix}
\RequirePackage{balance}
\RequirePackage{textcomp}
\RequirePackage{geometry}
\geometry{%
   hmargin=2.5cm,
   vmargin={2cm,2.5cm},
   bindingoffset=3mm,
   columnsep=15pt
}
\newwrite\@bibentry
\newwrite\@abstractout
\newwrite\AT@articlepath
\newif\if@fvrbex
\newif\if@hyperref
\def\openarticlehook{}
\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >\m@ne
       \Large\bfseries \partname\nobreakspace\thepart:
       \par\nobreak
     \fi
%      \huge \bfseries #2%
     #2%
     \markboth{}{}\par}%
    \nobreak
    \vskip 3ex
    \@afterheading}
\def\@spart#1{%
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
%      \huge \bfseries #1\par}%
     \Large \bfseries #1\par}%
     \nobreak
     \vskip 3ex
     \@afterheading}
\renewcommand{\section}{\@startsection{section}{1}{\z@}%
  {-1\baselineskip \@plus -.2ex \@minus -.1ex}{.5\baselineskip \@plus .2ex}{\normalfont\large\bfseries}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
   {-0.5\baselineskip \@plus -.2ex \@minus -.1ex}{1ex \@plus .2ex}{\normalfont\normalsize\bfseries}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
    {-0.5\baselineskip \@plus -.2ex \@minus -.1ex}{1ex \@plus .2ex}{\normalfont\normalsize\itshape}}
\renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
    {-0.5\baselineskip \@plus -.2ex \@minus -.1ex}{1ex \@plus .2ex}{\normalfont\normalsize\itshape}}
\renewcommand{\subparagraph}{\@startsection{subparagraph}{5}{\z@}%
    {-0.5\baselineskip \@plus -.2ex \@minus -.1ex}{1ex \@plus .2ex}{\normalfont\normalsize\itshape}}

\newcommand{\pretitle}[1]{\def\@atpretitle{#1}}
\newcommand{\posttitle}[1]{\def\@atposttitle{#1}}
\newcommand{\preauthor}[1]{\def\@atpreauthor{#1}}
\newcommand{\postauthor}[1]{\def\@atpostauthor{#1}}
\newcommand{\predate}[1]{\def\@atpredate{#1}}
\newcommand{\postdate}[1]{\def\@atpostdate{#1}}

\pretitle{%
  \begin{center}\LARGE\bfseries
}
\posttitle{%
  \par\end{center}%
  \vskip 0.5em
}
\preauthor{\begin{center}
  \large\itshape \lineskip .5em%
  \begin{tabular}[t]{c}}
\postauthor{\end{tabular}\par\end{center}}
\predate{\begin{center}\large}
\postdate{\par\end{center}}

\newcommand{\maketitlehooka}{}
\newcommand{\maketitlehookb}{}
\newcommand{\maketitlehookc}{}
\newcommand{\maketitlehookd}{}

\newcommand{\thanksmarkseries}[1]{%
  \def\@atmarkseries{\renewcommand{\thefootnote}{\@nameuse{#1}{footnote}}}}
\newcommand{\symbolthanksmark}{\thanksmarkseries{fnsymbol}}
\newcommand{\@atcontmark}{\setcounter{footnote}{0}}
\newcommand{\continuousmarks}{\def\@atcontmark{}}
\newcommand{\thanksheadextra}[2]{%
  \def\@atthanksheadpre{#1}%
  \def\@atthanksheadpost{#2}}
\newcommand{\thanksfootextra}[2]{%
  \def\thanksfootpre{#1}%
  \def\thanksfootpost{#2}}

\DeclareRobustCommand{\thanksmark}[1]{\footnotemark[#1]}
\newcommand{\thanksgap}[1]{\hspace{#1}}
\newcommand{\tamark}{\@thefnmark}

\newlength{\thanksmarkwidth}
\newlength{\thanksmargin}
\newcommand{\thanksscript}[1]{\textsuperscript{#1}}
\newcommand{\makethanksmarkhook}{}

\newcommand{\thanksfootmark}{%
  \hb@xt@\thanksmarkwidth{\hfil\normalfont\thanksscript{%
    \thanksfootpre \tamark \thanksfootpost}}}

\newcommand{\makethanksmark}{%
  \leavevmode%
  \makethanksmarkhook\relax
  \parindent 1em\noindent
  \leftskip\thanksmargin\relax
  \advance\leftskip \thanksmarkwidth \null\nobreak\hskip -\leftskip
  \thanksfootmark
}

\newcommand{\usethanksrule}{\let\footnoterule\thanksrule}
\newcommand{\cancelthanksrule}{\let\footnoterule\@atfootnoterule}

\symbolthanksmark

\thanksheadextra{}{}
\thanksfootextra{}{}
\setlength{\thanksmarkwidth}{1.8em}
\setlength{\thanksmargin}{-\thanksmarkwidth}

\AtBeginDocument{%
  \let\AtBeginDocument\AtEndOfPackage
  \let\thanksrule\footnoterule
  \let\@atfootnoterule\footnoterule
}

\renewcommand{\maketitle}{\par
  \begingroup
    \@atmarkseries
    \def\@makefnmark{\rlap{\@textsuperscript{%
       \normalfont\@atthanksheadpre \tamark \@atthanksheadpost}}}%
    \long\def\@makefntext##1{\makethanksmark ##1}
        \twocolumn[\@maketitle]%
    \thispagestyle{plain}\@thanks
  \endgroup
  \@atcontmark  %  \setcounter{footnote}{0}%
}

\renewcommand{\title}[2][\@empty]{%
  \gdef\@title{#2}%
  \begingroup
  \renewcommand{\thanks}[1]{}
  \renewcommand{\thanksmark}[1]{}
  \renewcommand{\thanksgap}[1]{}
  \ifx#1\@empty%
    \protected@xdef\thetitle{#2}%
  \else
    \protected@xdef\thetitle{#1}%
  \fi
  \endgroup
}
\newcounter{author}
\setcounter{author}{0}
\def\addto@theauthorlist#1{
  \begingroup
  \renewcommand{\thanks}[1]{}
  \renewcommand{\thanksmark}[1]{}
  \renewcommand{\thanksgap}[1]{}
  \protected@xdef\theauthorlist{%
    \theauthorlist\ifnum\c@author=\@ne\else,\ \fi#1}
  \protected@xdef\AT@authors@bibentry{%
    \AT@authors@bibentry\ifnum\c@author=\@ne\else\space and\space \fi#1}
  \endgroup
}
\def\AT@makekey@bibentry#1#2#3#4#5#6#7#8#9\@empty{\def\AT@authorinkey@bibentry{#1#2#3#4#5#6#7#8}}
\let\originaltextlatin\textlatin
\let\textlatin\relax
\renewcommand{\author}[1]{%
  \stepcounter{author}
  \ifnum\c@author=1\AT@makekey@bibentry#1\null\null\null\null\null\null\@empty\fi
  \expandafter\gdef\csname author@\romannumeral\c@author\endcsname{#1}
  \addto@theauthorlist{#1}
}
\edef\theauthorlist{}
\edef\AT@authors@bibentry{}
\def\@authorlist{%
  \@tempcntb\@ne
  \@whilenum\c@author>\@tempcntb\do{%
    {\@nameuse{author@\romannumeral\@tempcntb}, }%
    \advance\@tempcntb\@ne
  }%
  \@nameuse{author@\romannumeral\@tempcntb}
}

\newcommand{\address}[1]{%
  \expandafter\gdef\csname address@\romannumeral\c@author\endcsname{#1}
}
\newcommand{\netaddress}[1]{%
  \expandafter\gdef\csname netaddress@\romannumeral\c@author\endcsname{#1}
}
\newcounter{title}
\setcounter{title}{0}
\newcommand{\theHtitle}{\arabic{title}}
\def\title@toc@entry#1{%
  \if@hyperref
  \xdef\@currentHref{title.\theHtitle}%
  \Hy@raisedlink{\hyper@anchorstart{\@currentHref}\hyper@anchorend}%
  \else\fi
  \csname toc@entry@#1\endcsname}
\let\toc@entry@paper\relax
\let\toc@entry@standalone\relax
\newwrite\AT@lst
\def\toc@entry@journal{
  \def\emptystring{}
  \ifx\theauthorlist\emptystring
    {\let\thanks\@gobble\addcontentsline{toc}{title}{{\@title}}}
  \else
    {\let\thanks\@gobble\addcontentsline{toc}{title}{{\@title}\newline \emph{\theauthorlist}}}
  \fi
  %\addcontentsline{toc}{title}{\thetitle\newline \emph{\theauthorlist}}
  \protected@write\AT@lst{\let\thanks\@gobble \let\label\@gobble \let\index\@gobble \let\glossary\@gobble}{%
    %\protect\@titleline{\theauthorlist}{\thetitle}{\thepage}}
    \protect\@titleline{\theauthorlist}{\@title}{\thepage}}
}
\newcommand\ATarticlelist{%
  \begin{center}
  \large
  \list{}{\parsep=0pt \let\makelabel\ATindexlabel \labelsep=1em \listparindent=2.5em}
  \makeatletter
  \InputIfFileExists{artlist.lst}{}{}%
  \makeatother
  \endlist
  \end{center}
}
\newcommand\ATindexlabel[1]{%
  \makebox[2.5em][r]{#1}}
\newcommand\@titleline[3]{%
  \newdimen\tmp%
  \advance\tmp by \textwidth%
  \advance\tmp by -4.5em%
%% The \phantom{q}s are to correct the depth of those lines with no descenders
  \item[#3] \begin{minipage}[t]{\tmp}#2\phantom{q}\par%
  \textit{#1}\phantom{q}%
  \end{minipage}
}
\def\@atdate#1{\csname date@#1\endcsname}
\let\date@paper\relax
\let\date@journal\relax
\def\date@standalone{\@atpredate \@date \@atpostdate}
\def\@maketitle{%
  \stepcounter{title}
  \title@toc@entry{\@pjp}
  \vspace{\@articlesep}
  \maketitlehooka
  {\@atpretitle \@title \@atposttitle}
  \maketitlehookb
  {\@atpreauthor \@authorlist \@atpostauthor}
  \maketitlehookc
  {\@atdate{\@pjp}}
  \maketitlehookd
  \par
  \vskip 1.5em
}

\newlength\sigindent
\setlength\sigindent{.25\columnwidth}
\def\@makesig{%
  \if@fvrbex\long\def\@gobble##1{}\else\fi
  \renewcommand{\thanks}[1]{}
  \renewcommand{\thanksmark}[1]{}
  \renewcommand{\thanksgap}[1]{}
  \vspace{\DropSig}
  \list{}{\topsep\z@ \parsep\z@ \leftmargin=\sigindent \partopsep\z@}
  \@tempcntb\z@
  \@whilenum\c@author>\@tempcntb\do{%
    \advance\@tempcntb\@ne
    \item[\SigSymbol]
    \@usenempty{author@\romannumeral\@tempcntb}\par\nobreak
    \@usenempty{address@\romannumeral\@tempcntb}\par\nobreak
    \texttt{\@usenempty{netaddress@\romannumeral\@tempcntb}}
    }
  \endlist
  \gdef\@thanks{}
  \if@fvrbex\def\@gobble##1{}\else\fi
}
\def\AT@tablecaptions{%
  \setlength{\belowcaptionskip}{\abovecaptionskip}%
  \setlength{\abovecaptionskip}{0pt}%
}
\def\AT@figurecaptions{}
\AtBeginDocument{%
\long\def\@makecaption#1#2{%
  \@nameuse{AT@\@captype captions}
  \footnotesize
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\textsc{#1}: #2}%
  \ifdim \wd\@tempboxa >\hsize
    \textsc{#1}: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
}
\newcounter{article}
\newenvironment{article}{%
  \@openarticle}{\@closearticle\clearpage}
\newcommand{\theHarticle}{\arabic{article}}

\def\@paperhead{\ATname\ N\textordmasculine\ 0, Dicembre 2099}
\def\@journalhead{\ATname\ N\textordmasculine\ \AT@number, \AT@month\ \AT@year}
\def\ps@paper{%
  \def\@oddfoot{\hfil\thepage\hfil}
  \def\@evenfoot{\hfil\thepage\hfil}
  \def\@oddhead{\@paperhead\hfil\thetitle}
  \def\@evenhead{\theauthorlist\hfil\@paperhead}
}
\def\ps@journal{%
  \def\@oddfoot{\hfil\thepage\hfil}
  \def\@evenfoot{\hfil\thepage\hfil}
  \def\@oddhead{\@headfont\@journalhead\hfil\thetitle}
  \def\@evenhead{\@headfont\theauthorlist\hfil\@journalhead}
}
\def\ps@standalone{%
  \def\@oddfoot{\hfil\thepage\hfil}
  \def\@evenfoot{\hfil\thepage\hfil}
  \def\@oddhead{\thetitle\hfil{\itshape\theauthorlist}}
  \def\@evenhead{{\itshape\theauthorlist}\hfil\thetitle}
}
\let\ps@toc\ps@empty
\AtBeginDocument{%
  \pagestyle{\@pjp}
  \let\AT@thebibliography\thebibliography
  \def\thebibliography{%
    \let\sloppy\@atbibliopatch
    \AT@thebibliography
  }
  \@ifpackageloaded{fvrb-ex}{\@fvrbextrue}{\@fvrbexfalse}
  \@ifpackageloaded{hyperref}{\@hyperreftrue}{\@hyperreffalse}
}
\def\@atbibliopatch{%
  \@atbibfont
  \@atbibjustification
}
\def\@atbibfont{}
\def\@atbibjustification{}%{\raggedright}

\def\toclevel@title{0}
\let\@oldtoc\tableofcontents
\def\BlackBoxes{\overfullrule=5\p@}
\def\NoBlackBoxes{\overfullrule=\z@}
\def\ATname{\Ars}
\newcommand*\pkgname[1]{\textsf{#1}}
\newcommand*\clsname[1]{\textsf{#1}}
\newcommand*\optname[1]{\textsf{#1}}
\newcommand*\envname[1]{\textsf{#1}}
\DeclareRobustCommand\cmdname[1]{\texttt{\char`\\#1}}
\DeclareRobustCommand\meta[1]{%
  \ensuremath{\langle}\emph{#1}\ensuremath{\rangle}}
\def\@cfgfound{\ClassInfo{arstexnica}{Info loaded from \jobname.cfg.}}
\def\@cfgnotfound{\ClassWarning{arstexnica}{Config file not found.}}

\def\@usenempty#1{%
  \csname #1\endcsname
  \global\expandafter\let\csname #1\endcsname\@empty
}

\def\footnoterule{}
\def\class@name{arstexnica}
\newlength\@articlesep
\setlength\@articlesep\z@

\newcommand\IssueLine{{\IssueLineFont Numero \AT@number, \AT@month\ \AT@year}}
\newcommand\IssueLineFont{\Large\itshape}
\newcommand\@headfont{\itshape}
\newcommand*\SigSymbol{\ensuremath{\triangleright}}
\newlength\DropSig
\setlength\DropSig{2\baselineskip}
\newlength{\arswidth}

\renewcommand\@makefntext[1]{%
    \parindent 1em%
    \@thefnmark.\kern1.5mm#1}

\def\AT@padded@startpage{%
  \ifnum\AT@init@page>99\else\ifnum\c@page>9 0\thepage\else00\thepage\fi\fi}
\begingroup
  \catcode`\[ = 1\relax
  \catcode`\] = 2\relax
  \catcode`\{ = 12\relax
  \catcode`\} = 12 \relax
  \gdef\AT@open@bibentry[@Article{at:\AT@year-\AT@number-\AT@padded@startpage-\AT@authorinkey@bibentry,]
  \gdef\AT@close@bibentry[}]
\endgroup
\def\AT@indent@bibentry{\space\space}
\def\AT@write@bibentry{%
  \immediate\openout\@bibentry \currfiledir\currfilebase.bib
  \protected@write\@bibentry{}{\AT@open@bibentry}
  \protected@write\@bibentry{}{\AT@indent@bibentry author = {\AT@authors@bibentry},}
  \protected@write\@bibentry{}{\AT@indent@bibentry title = {\@title},}
  \protected@write\@bibentry{}{\AT@indent@bibentry journal = {Ars\TeX nica},}
  \protected@write\@bibentry{}{\AT@indent@bibentry year = \AT@year,}
  \protected@write\@bibentry{}{\AT@indent@bibentry number = \AT@number,}
  \protected@write\@bibentry{}{\AT@indent@bibentry pages = {\AT@init@page-\AT@end@page},}
  \protected@write\@bibentry{}{\AT@indent@bibentry month = {\AT@month},}
  \protected@write\@bibentry{}{\AT@indent@bibentry language = {\languagename},}
  \protected@write\@bibentry{}{\AT@indent@bibentry issn = {1828-2350},}
  \protected@write\@bibentry{}{\AT@close@bibentry}
}

\newcommand{\lstrestoredefault}{
  \lstset{abovecaptionskip=\smallskipamount,
      aboveskip=\medskipamount,
      backgroundcolor={},
      basicstyle={},
      belowcaptionskip=\smallskipamount,
      belowskip=\medskipamount,
      breakautoindent=true,
      breaklines=false,
      captionpos=t,
      columns=[c]fixed,
      commentstyle=\itshape,
%      emph=,
      emphstyle=\bfseries,
%      emph={[2]},
      emphstyle={[2]\bfseries},
      emptylines=2,
      escapeinside={},
      extendedchars=true,
      firstline=1,
      float=tbp,
      frame=none,
      frameround=ffff,
      gobble=0,
      identifierstyle={},
      keepspaces=false,
      keywordstyle=\bfseries,
      language={},
      lineskip=0pt,
      literate={},
      mathescape=false,
      morekeywords={},
      numbers=none,
      numbersep=10pt,
      numberstyle={},
      prebreak={},
      showspaces=false,
      showstringspaces=true,
      stepnumber=1,
      stringstyle={},
      texcsstyle=*{},
      xleftmargin=0pt,
      xrightmargin=0pt}}
%% thanks to C. Beccari
\def\manualbalance{%
 \ifvmode
   \vfill
   \penalty -\@M%
 \else
   \@bsphack
   \vadjust{\vspace{\z@\@plus1fill}\penalty -\@M}%
   \@esphack
 \fi}

\frenchspacing
\endinput
