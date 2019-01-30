
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{rapport}[2017/08/17 HiSReport]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\newcommand{\beautifylistofauthors}[5]{%
\ifthenelse{\equal{#2}{}}{\hypersetup{pdfauthor={#1}}}{\ifthenelse{\equal{#3}{}}{\hypersetup{pdfauthor={#1 and #2}}}{\ifthenelse{\equal{#4}{}}{\hypersetup{pdfauthor={#1, #2, and #3}}}{\ifthenelse{\equal{#5}{}}{\hypersetup{pdfauthor={#1, #2, #3, and #4}}}{\hypersetup{pdfauthor={#1, #2, #3, #4, and #5}}}}}}%
}

\DeclareOption{english}{%
\PassOptionsToClass{\CurrentOption}{babel}%
}
\DeclareOption{swedish}{%
\PassOptionsToClass{\CurrentOption}{babel}%
\renewcommand{\beautifylistofauthors}[5]{%
\ifthenelse{\equal{#2}{}}{\hypersetup{pdfauthor={#1}}}{\ifthenelse{\equal{#3}{}}{\hypersetup{pdfauthor={#1 och #2}}}{\ifthenelse{\equal{#4}{}}{\hypersetup{pdfauthor={#1, #2 och #3}}}{\ifthenelse{\equal{#5}{}}{\hypersetup{pdfauthor={#1, #2, #3 och #4}}}{\hypersetup{pdfauthor={#1, #2, #3, #4 och #5}}}}}}%
}
}

\newcommand{\labelExaminer}{Examiner}
\newcommand{\labelSupervisor}{Supervisor}
\DeclareOption{swedish}{%
\renewcommand{\labelExaminer}{Examinator}
\renewcommand{\labelSupervisor}{Handledare}
}

\ProcessOptions

\LoadClass[12pt]{article}

\RequirePackage[a4paper,margin=2.5cm]{geometry}
\RequirePackage[pdftex]{graphicx}
\RequirePackage[pdfborder={0 0 0}]{hyperref}

\RequirePackage{ifxetex}
\RequirePackage{ifluatex}
\ifxetex
  % code used only by xetex
  \RequirePackage[no-math]{fontspec}
  \defaultfontfeatures{Ligatures=TeX}
  \setmonofont[Scale=0.825]{DejaVu Sans Mono}
  \setsansfont{Nimbus Sans L}
  % \setmainfont{TeX Gyre Termes}% based on Nimbus Roman
  \setmainfont{Georgia}
\else
  \ifluatex
    % code used only by luatex
    \RequirePackage[no-math]{fontspec}
    \defaultfontfeatures{Ligatures=TeX}
    \setmonofont[Scale=0.825]{DejaVu Sans Mono}
    \setsansfont{Nimbus Sans L}
    % \setmainfont{TeX Gyre Termes}% based on Nimbus Roman
    \setmainfont{Georgia}
  \else
    % code used by neither luatex nor xetex
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage[scaled=0.825]{DejaVuSansMono}
    \RequirePackage{helvet}
    \RequirePackage{mathptmx}
  \fi
\fi


% Package to handle conditions
\RequirePackage{ifthen}

% Package to handle conditions
\RequirePackage{ragged2e}


% \RequirePackage{tikz}
% \usetikzlibrary{positioning}

\RequirePackage{eso-pic}
\RequirePackage{kvoptions}
\RequirePackage{optparams}

\newcommand{\figref}[1]{Fig.\,\ref{#1}}
\newcommand{\tabref}[1]{Tab.\,\ref{#1}}



\newcommand{\missingparam}[1]{\ensuremath{\langle}\textbf{\textbackslash{}#1}{\normalfont\ missing}\ensuremath{\rangle}}


\newcommand{\TheAuthorA}{\missingparam{author%
\ifthenelse{\equal{rapport}{\HiSReporttemplate}}{{\normalfont\ or \textbackslash}authors}{}%
\ifthenelse{\equal{report}{\HiSReporttemplate}}{{\normalfont\ or \textbackslash}authors}{}%
}}
\newcommand{\TheAuthorB}{}
\newcommand{\TheAuthorC}{}
\newcommand{\TheAuthorD}{}
\newcommand{\TheAuthorE}{}
\long\def\authors@[#1][#2][#3][#4]#5{%
\renewcommand{\TheAuthorE}{#4}
\renewcommand{\TheAuthorD}{#3}
\renewcommand{\TheAuthorC}{#2}
\renewcommand{\TheAuthorB}{#1}
\renewcommand{\TheAuthorA}{#5}
\beautifylistofauthors{#5}{#1}{#2}{#3}{#4}
}
\newcommand{\authors}{%
\optparams{\authors@}{[][][][]}%
}
\renewcommand\author[1]{\authors{#1}}


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
\TheAuthorA\\%
\ifthenelse{\equal{\TheAuthorB}{}}{}{\TheAuthorB\\\ifthenelse{\equal{\TheAuthorC}{}}{}{\TheAuthorC\\\ifthenelse{\equal{\TheAuthorD}{}}{}{\TheAuthorD\\\ifthenelse{\equal{\TheAuthorE}{}}{}{\TheAuthorE\\}}}}
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
