\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arstexnica}[2024/12/15 v1.0.1 Document class for Ars TeXnica]
\RequirePackage{guit}
\RequirePackage{currfile}
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
\newif\ifAT@paper\AT@paperfalse
\newif\ifAT@sig\AT@sigtrue
\newif\ifAT@print\AT@printfalse
\DeclareOption{draft}{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\DeclareOption{final}{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\DeclareOption{paper}{%
  \AT@papertrue
  \def\@pjp{paper}
  \AtEndOfClass{%
    \let\tableofcontents\relax
    \def\@openarticle{}
    \def\@closearticle{\@makesig}
  }
}
\DeclareOption{online}{%
  \def\AT@mode{online}
  \AT@printfalse
}
\DeclareOption{print}{%
  \def\AT@mode{print}
  \AT@printtrue
}
\DeclareOption{nosig}{%
  \AT@sigfalse
}
\ExecuteOptions{draft,paper,noimpose,online}
\ProcessOptions
\LoadClass[b5paper,twoside,10pt]{article}
\RequirePackage{textcase}

\DeclareRobustCommand*{\arsweb}{\url{http://www.guitex.org/arstexnica/}}% Indirizzo web ArsTeXnica

\RequirePackage{arsacro}
\RequirePackage{balance}
\RequirePackage{textcomp}
\RequirePackage{geometry}
\geometry{%
  b5paper,
  textwidth=28cc,
  textheight=43cc,
  vmarginratio=1:1,
  headsep=1cc,
  twoside,
  heightrounded,
}
\ifAT@print
\geometry{%
  hmarginratio=1:2,
  bindingoffset=3mm,
}
\else
\geometry{%
  hmarginratio=1:1,
}
\fi
\newif\if@fvrbex
\newif\if@hyperref
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

\RequirePackage{titling}
\newcounter{title}
\setcounter{title}{0}
\providecommand{\theHtitle}{\arabic{title}}
\def\title@toc@entry#1{%
  \if@hyperref
  \xdef\@currentHref{title.\theHtitle}%
  \Hy@raisedlink{\hyper@anchorstart{\@currentHref}\hyper@anchorend}%
  \else\fi
  \csname toc@entry@#1\endcsname}
\let\toc@entry@paper\relax
\newwrite\AT@lst % Per i titoli degli articoli nei sommari
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
\newif\if@ATbreakbeforeaddresses
\@ATbreakbeforeaddressesfalse
\def\AT@maybebreak{\if@ATbreakbeforeaddresses\clearpage\fi}
\def\AddressesOnNewPage{\@ATbreakbeforeaddressestrue}
\newcounter{AT@author@cnt}
\setcounter{AT@author@cnt}{0}
\newcounter{AT@temp}
\setcounter{AT@temp}{0}
\def\@author{}
\def\theauthor{\setcounter{AT@temp}{0}}
\def\AT@addresses{\AT@maybebreak}
\def\AT@author@sep{%
  \stepcounter{AT@temp}%
  \ifnum\c@AT@temp=1\relax\else%
    \ifnum\c@AT@temp=\c@AT@author@cnt%
      \space e\space%
    \else%
      ,\space
    \fi%
  \fi%
}
\def\AT@addr@sep{%
  \stepcounter{AT@temp}%
  \par\vskip3pt
  % \item[]
}
\def\AT@dest{}
\def\AT@target{}
\newcommand\AT@set@links[2]{%
  \def\AT@dest{#1}%
  \def\AT@target{#2}%
}
\def\AT@affil@sep{}
\def\AT@email@sep{}
\newcommand\AT@hyperlink[1]{%
  \hyperlink{\AT@dest-\c@AT@temp}{\Hy@raisedlink{\hypertarget{\AT@target-\c@AT@temp}{}}#1}%
}
\def\AT@affiliation@mark{%
  \ifnum\c@AT@author@cnt>1%
    \AT@hyperlink{\textsuperscript{\theAT@temp}}\unskip%
  \fi%
}
\def\addto@theauthorlist#1{
  \begingroup%
  \renewcommand{\thanks}[1]{}%
  \renewcommand{\thanksmark}[1]{}%
  \renewcommand{\thanksgap}[1]{}%
  \ifnum\c@AT@author@cnt=\@ne%
    \protected@xdef\@firstauthor{#1}%
  \fi%
  \protected@xdef\theauthorlist{%
    \theauthorlist\ifnum\c@AT@author@cnt=\@ne\else,\ \fi#1}%
  \endgroup%
}
\edef\theauthorlist{}
\renewcommand\author[1]{%
  \stepcounter{AT@author@cnt}%
  % \g@addto@macro\@author{\AT@author@sep#1\AT@affiliation@mark}%
  \addto@theauthorlist{#1}%
  \g@addto@macro\@author{\AT@author@sep#1}%
  \g@addto@macro\theauthor{\AT@author@sep#1}%
  \g@addto@macro\AT@addresses{%
    \AT@addr@sep%
    \def\AT@affil@sep{\newline}%
    \def\AT@email@sep{\newline}%
    \hangfrom{\phantom{1}}#1%
  }%
  \AT@authors@hook{#1}%
}
\def\AT@authors@hook{}
\newcommand\address[1]{%
  \ifblank{#1}{}{%
    \g@addto@macro\AT@addresses{%
      \AT@affil@sep\textsc{#1}%
    }%
  }%
}
\newcommand\netaddress[1]{\ifblank{#1}{}{\g@addto@macro\AT@addresses{\AT@email@sep\url{#1}}}}
\newcommand{\hangfrom}[1]{%
  \setbox\@tempboxa\hbox{{#1}}%
  \hangindent \wd\@tempboxa\noindent\box\@tempboxa}

\let\AT@thanks\thanks
\def\thanks#1{\NoCaseChange{\AT@thanks{#1}}}
\setlength\droptitle{-\topskip}
\g@addto@macro\maketitle{%
  \stepcounter{title}%
  \title@toc@entry{\@pjp}%
  \thispagestyle{first}%
}
\pretitle{%
  \nointerlineskip\raggedright\bfseries\LARGE
}
\posttitle{\par}
\renewcommand\maketitlehookb{\vspace{1cc}}
\preauthor{%
%  \AT@set@links{aff}{au}
  \raggedright
}
\postauthor{\par}
\renewcommand\maketitlehookc{\vspace{3\baselineskip}\date{}}
\predate{} \postdate{}
\renewcommand\maketitlehookd{\par\vspace{\dimexpr-1.5em-\topsep}}

\newlength\ATsigsep
\setlength\ATsigsep{1.5\baselineskip minus 6pt}
\def\@makesig{%
  \ifAT@sig
    \setcounter{AT@temp}{0}
    \small
    \vspace{\ATsigsep}
    \AT@set@links{au}{aff}
    \AT@addresses
  \fi
}

\RequirePackage[runin]{abstract}
\AtBeginDocument{
  \abslabeldelim{\hspace{.5em}}
  \setlength\absparindent{\parindent}
  \setlength\abstitleskip{-\absparindent}
}

\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname.\quad}
\renewcommand\abstractnamefont{\normalfont\small\bfseries}
\setlength\absleftindent{0pt}
\setlength\absrightindent{0pt}
\renewcommand{\section}{\@startsection{section}{1}{\z@}%
  {-2\baselineskip \@plus -.2ex \@minus -.1ex}{1\baselineskip \@plus .2ex}{\normalfont\normalsize\bfseries}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
  {-1\baselineskip \@plus -.2ex \@minus -.1ex}{.5\baselineskip \@plus .2ex}{\normalfont\normalsize\itshape}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
  {-1\baselineskip \@plus -.2ex \@minus -.1ex}{.5\baselineskip \@plus .2ex}{\normalfont\normalsize\itshape}}
\renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
  {-1\baselineskip \@plus -.2ex \@minus -.1ex}{.5\baselineskip \@plus .2ex}{\normalfont\normalsize\itshape}}
\renewcommand{\subparagraph}{\@startsection{subparagraph}{5}{\z@}%
  {-1\baselineskip \@plus -.2ex \@minus -.1ex}{.5\baselineskip \@plus .2ex}{\normalfont\normalsize\itshape}}

\RequirePackage{caption}
\AtBeginDocument{
  \captionsetup{
    singlelinecheck=off,
    format=plain,
    labelformat=original,
    labelsep=period,
    justification=justified,
    font=small,
    labelfont=bf,
  }
}
\RequirePackage[hang,norule]{footmisc}
\setlength\footnotemargin{1.25em}
\patchcmd{\@makefntext}{\@makefnmark}{\AT@makefnmark}{}{}
\def\AT@makefnmark{\@thefnmark.\kern2mm}
\newcounter{article}
\newenvironment{article}{%
  \@openarticle}{\@closearticle\clearpage}

\def\AT@number{}
\def\AT@month{}
\def\AT@year{}
\def\@paperhead{\small\Ars\hfill Preprint~{\textperiodcentered}~\today}
\def\ps@paper{%
  \def\@oddfoot{\@paperhead}
  \def\@evenfoot{\@paperhead}
  \def\@oddhead{{\thetitle}\hfil\thepage}
  \def\@evenhead{\thepage\hfil{\theauthor}}
}
\def\ps@first{%
  \def\@oddfoot{\@paperhead}
  \def\@evenfoot{\@paperhead}
  \def\@oddhead{}
  \def\@evenhead{}
}
\let\ps@toc\ps@empty
\let\ps@plain\ps@empty
\let\ps@injournal\ps@empty
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
\let\pack\pkgname
\newcommand*\clsname[1]{\textsf{#1}}
\let\class\clsname
\newcommand*\optname[1]{\textsf{#1}}
\let\opz\optname
\newcommand*\envname[1]{\textsf{#1}}
\let\env\envname
\DeclareRobustCommand\cmdname[1]{\texttt{\char`\\#1}}
\let\cs\cmdname
\DeclareRobustCommand\meta[1]{%
  {\normalfont\ensuremath{\langle}\emph{#1}\ensuremath{\rangle}}}
\newcommand*\marg[1]{\texttt{\{\meta{#1}\}}}
\newcommand*\oarg[1]{\texttt{[\meta{#1}]}}
\newcommand*\Arg[1]{\texttt{\char123#1\char125}}
\newcommand*\prog[1]{\textsf{#1}}
\newcommand*\file[1]{\texttt{#1}}
\newcommand*\amb[1]{\textit{#1}}
\def\@cfgfound{\ClassInfo{arstexnica}{Info loaded from \jobname.cfg.}}
\def\@cfgnotfound{\ClassWarning{arstexnica}{Config file not found.}}

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

% \renewcommand\@makefntext[1]{%
%     \parindent 1em%
%     \@thefnmark.\kern1.5mm#1}

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

\def\toclevel@ATtitle{-1}

\colorlet{ATLinkColoronline}{blue!30!black}
\colorlet{ATLinkColorprint}{black}

\AtBeginDocument{
  \colorlet{ATLinkColor}{ATLinkColor\AT@mode}
  \hypersetup{% Attenzione: hyperref è sempre caricato! Dal pacchetto `guit', chiamato da `arstestata', chiamato da `arstexnica'. Non è più vero almeno dal 2012 (v0.9.1 di guit.sty).
    colorlinks  = true,  
    citecolor   = ATLinkColor,
    linkcolor   = ATLinkColor, 
    urlcolor    = ATLinkColor, 
    bookmarksdepth = 3,
    pdfencoding = auto,
  }
}


\frenchspacing
\endinput
