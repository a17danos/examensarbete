% his.cls is a LaTeX class for student reports
% This class is written by Thomas Fischer <thomas.fischer@his.se>
% and licensed by the Creative Commons Attribution-Share Alike 3.0 License
% http://creativecommons.org/licenses/by-sa/3.0/
% It has been adapted by Daniel Oskarsson <a17danos@student.his.se>

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{his}[2017/08/17 HiSReportModified]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\newcommand{\labelExaminer}{Examiner}
\newcommand{\labelSupervisor}{Supervisor}
\newcommand{\labelKeywords}{Keywords}
\DeclareOption{swedish}{%
\renewcommand{\labelExaminer}{Examinator}
\renewcommand{\labelSupervisor}{Handledare}
\renewcommand{\labelKeywords}{Nyckelord}
}

\ProcessOptions

\LoadClass[12pt]{article}

% Support listings
\RequirePackage{listings}
\RequirePackage{caption}
\captionsetup{font=footnotesize,labelfont=bf}
\lstset{
    aboveskip=0cm,
    stringstyle=\ttfamily,
    showstringspaces = false,
    basicstyle=\scriptsize\ttfamily,
    commentstyle=\color{gray!80},
    keywordstyle=\bfseries,
    ndkeywordstyle=\bfseries,
    identifierstyle=\ttfamily,
    tabsize=4,
    frame=none,
    numbers=none,
    numbersep=15pt,
    numberstyle=\tiny,
    numberfirstline = false,
    breaklines=true
}
\lstdefinelanguage{JavaScript}{
  keywords={typeof, new, true, false, catch, function, return, null, catch, switch, var, const, let, async, await, if, in, while, do, else, case, break, from},
  ndkeywords={class, export, boolean, throw, implements, import, this},
  sensitive=false,
  comment=[l]{//},
  morecomment=[s]{/*}{*/},
  morestring=[b]',
  morestring=[b]",
  captionpos=t
}

% Format abstract
\RequirePackage{abstract}
\renewcommand{\abstractnamefont}{\normalfont\Large\bfseries}

% Format references
\RequirePackage[style=authoryear,url=false,doi=false,isbn=false,dashed=false,
            mincitenames=3, maxbibnames=99,
            uniquename=init,giveninits=true,
            backend=biber]{biblatex}
\addbibresource{bibliography.bib}
% Enforce to have always a lastname-comma-firstname layout
\DeclareNameAlias{sortname}{last-first}
\DeclareNameAlias{default}{last-first}
% Use ampersand as last author names separator
\AtBeginBibliography{%
  \renewcommand*{\finalnamedelim}{%
    \ifnumgreater{\value{liststop}}{2}{\finalandcomma}{}%
    \addspace\&\space}
}
% Set the parencite context specifically to use an ampersand
\DeclareDelimFormat[parencite]{finalnamedelim}{%
  \ifnumgreater{\value{liststop}}{2}{\finalandcomma}{}%
  \addspace\&\space}

\RequirePackage[a4paper,margin=2.5cm]{geometry}
\RequirePackage[pdftex]{graphicx}
\RequirePackage[pdfborder={0 0 0}]{hyperref}

\RequirePackage{ifxetex}
\RequirePackage{ifluatex}
\ifxetex
  \RequirePackage[no-math]{fontspec}
  \defaultfontfeatures{Ligatures=TeX}
  \setmonofont[Scale=0.825]{DejaVu Sans Mono}
  \setsansfont{Nimbus Sans L}
  \setmainfont{Georgia}
\else
  \ifluatex
    \RequirePackage[no-math]{fontspec}
    \defaultfontfeatures{Ligatures=TeX}
    \setmonofont[Scale=0.825]{DejaVu Sans Mono}
    \setsansfont{Nimbus Sans L}
    \setmainfont{Georgia}
  \else
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage[scaled=0.825]{DejaVuSansMono}
    \RequirePackage{helvet}
    \RequirePackage{mathptmx}
  \fi
\fi

\RequirePackage{ifthen}
\RequirePackage{ragged2e}
\RequirePackage{eso-pic}
\RequirePackage{kvoptions}
\RequirePackage{optparams}

\newcommand{\figref}[1]{Fig.\,\ref{#1}}
\newcommand{\tabref}[1]{Tab.\,\ref{#1}}
\newcommand{\missingparam}[1]{\ensuremath{\langle}\textbf{\textbackslash{}#1}{\normalfont\ missing}\ensuremath{\rangle}}

\newcommand{\TheTitleAltLang}{}
\newcommand{\TheTitle}{\missingparam{title}}
\renewcommand{\title}[2][]{\AtBeginDocument{\renewcommand{\TheTitle}{#2}%
\ifthenelse{\equal{\TheSubTitle}{}}{\hypersetup{pdftitle={\TheTitle}}}{\hypersetup{pdftitle={\TheTitle -- \TheSubTitle}}}%
\ifthenelse{\equal{#1}{}}{}{\renewcommand{\TheTitleAltLang}{#1}}}}

\newcommand{\TheSubTitleAltLang}{}
\newcommand{\TheSubTitle}{\missingparam{subtitle}}
\newcommand{\subtitle}[2][]{\AtBeginDocument{\renewcommand{\TheSubTitle}{#2}%
\ifthenelse{\equal{\TheSubTitle}{}}{\hypersetup{pdftitle={\TheTitle}}}{\hypersetup{pdftitle={\TheTitle -- \TheSubTitle}}}%
\ifthenelse{\equal{#1}{}}{}{\renewcommand{\TheSubTitleAltLang}{#1}}}}

\newcommand{\TheTimeFrame}{\missingparam{timeframe}}
\newcommand{\timeframe}[1]{\AtBeginDocument{\renewcommand{\TheTimeFrame}{#1}}}

\newcommand{\TheSupervisor}{\missingparam{supervisor}}
\newcommand{\supervisor}[1]{\AtBeginDocument{\renewcommand{\TheSupervisor}{#1}}}

\newcommand{\TheExaminer}{\missingparam{examiner}}
\newcommand{\examiner}[1]{\AtBeginDocument{\renewcommand{\TheExaminer}{#1}}}

\newcommand{\TheLevel}{\missingparam{level}}
\newcommand{\level}[1]{\AtBeginDocument{\renewcommand{\TheLevel}{#1}}}

\newcommand{\TheArea}{\missingparam{area}}
\newcommand{\area}[1]{\AtBeginDocument{\renewcommand{\TheArea}{#1}}}

\newcommand{\TheCourse}{\missingparam{course}}
\newcommand{\course}[1]{\AtBeginDocument{\renewcommand{\TheCourse}{#1}}}

\SetupKeyvalOptions{prefix=HiSReport}
\DeclareStringOption[rapport]{template}
\ProcessKeyvalOptions*

\renewcommand{\maketitle}{{%
\setlength{\parindent}{0cm}
\setlength{\parskip}{0cm}
\clearpage%
\thispagestyle{empty}%
\newgeometry{margin=0cm}%
\AddToShipoutPictureBG*{%
\includegraphics[height=\paperheight,width=\paperwidth,keepaspectratio]{cover.jpg}%
}
%
\vspace*{15.2cm}%
%
\hspace*{9.5cm}%
\begin{minipage}[t][5.9cm][t]{8.8cm}
\RaggedRight%
%
{\sffamily\bfseries\fontsize{17}{17}\selectfont\TheTitle}\par%
{\fontsize{15}{15}\selectfont\TheSubTitle}\par%
%
\ifthenelse{\equal{\TheTitleAltLang}{}}{}{%
\vspace{2em plus 1em minus 1ex}
{\sffamily\bfseries\fontsize{17}{17}\selectfont\TheTitleAltLang}\par%
{\fontsize{15}{15}\selectfont\TheSubTitleAltLang}\par%
}%
\end{minipage}%
\\
%
%
\hspace*{9.5cm}%
\begin{minipage}[t]{8.8cm}
\RaggedRight%
\fontsize{13}{13}\selectfont%
%
\ifthenelse{\equal{rapport}{\HiSReporttemplate}}{\TheCourse\\}{}%
%
\ifthenelse{\equal{rapport}{\HiSReporttemplate}}{\vspace*{1em}}{\ifthenelse{\equal{report}{\HiSReporttemplate}}{\vspace*{1em}}{%
\TheLevel\\%
\TheTimeFrame\\[1em]%
}}%
\@author\\%
\vspace*{1em}%
\ifthenelse{\equal{rapport}{\HiSReporttemplate}}{%
\TheTimeFrame%
}{\ifthenelse{\equal{report}{\HiSReporttemplate}}{%
\TheTimeFrame%
}{}}
\ifthenelse{\equal{\TheSupervisor\TheExaminer}{}}{}{%
\par%
\vspace*{1em}%
\ifthenelse{\equal{\TheSupervisor}{}}{}{\labelSupervisor: \TheSupervisor}%
\ifthenelse{\equal{\TheSupervisor}{}}{}{\ifthenelse{\equal{\TheExaminer}{}}{}{\par}}%
\ifthenelse{\equal{\TheExaminer}{}}{}{\labelExaminer: \TheExaminer}%
}
\end{minipage}

\restoregeometry%
\clearpage%
}}
