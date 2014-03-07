%% hgbreport.cls
%% Eine einfache LaTeX-Vorlage fuer Technical Reports
%% wilhelm.burger@fh-hagenberg.at

\NeedsTeXFormat{LaTeX2e}
%\newcommand{\hgbreportVersion}{0.90beta}  	%Versionsnummer
\newcommand{\hgbreportDate}{2008/11/20}			%Versionsdatum
\ProvidesClass{hgbreport}[\hgbreportDate\space LaTeX-Vorlage fuer Technical Reports]

\RequirePackage{ifthen}
\newboolean{hgb@reportHasChapters}\setboolean{hgb@reportHasChapters}{false}	%default: no chapters
\newcommand{\hgb@MainLanguage}{german} % also referenced in hgb.sty

%% begin class options ---------------------------------------------
\DeclareOption{chapters}{\setboolean{hgb@reportHasChapters}{true}} 
\DeclareOption{nochapters}{\setboolean{hgb@reportHasChapters}{false}} 
\DeclareOption{english}{\renewcommand{\hgb@MainLanguage}{english}}
\DeclareOption{german}{\renewcommand{\hgb@MainLanguage}{german}}
\DeclareOption*{\ClassWarning{hgbreport}{Unknown document option "\CurrentOption"}}
%\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
%% end class options ---------------------------------------------

\ifthenelse{\boolean{hgb@reportHasChapters}}%
   {\LoadClass[a4paper,11pt,oneside,notitlepage]{report}}%		%chapters --> report class
	 {\LoadClass[a4paper,11pt,oneside,notitlepage]{article}}		%no chapters --> article class

\RequirePackage{hgb}	% load associated style file hgb.sty

% define some language-specific nomenclature ---------------------

\newcommand{\hgb@TechnicalReportName}{}
\newcommand{\hgb@ByWord}{}
\newcommand{\hgb@KeywordsName}{}
\newcommand{\hgb@ReferenceName}{}

\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
	{\renewcommand{\hgb@TechnicalReportName}{Technischer Bericht}
	 \renewcommand{\hgb@ByWord}{von}
	 \renewcommand{\hgb@KeywordsName}{Schlüsselworte}
	 \renewcommand{\hgb@ReferenceName}{Quellenangabe}
	}{}
\ifthenelse{\equal{\hgb@MainLanguage}{english}}%
	{\renewcommand{\hgb@TechnicalReportName}{Technical Report}
	 \renewcommand{\hgb@ByWord}{by}
	 \renewcommand{\hgb@KeywordsName}{Index Terms}
	 \renewcommand{\hgb@ReferenceName}{Citation}
	}{}

%-------------- Setup für Seiten im Front-Teil --------------------

\newcommand{\hgb@Shorttitle}{\@title}	% used for headers
\newcommand{\Shorttitle}[1]{\renewcommand{\hgb@Shorttitle}{#1}}

\renewcommand{\thanks}[1]{}
\renewcommand{\@thanks}{\relax}

\newcommand{\hgb@Abstract}{\relax}
\newcommand{\Abstract}[1]{\renewcommand{\hgb@Abstract}{#1}}

\newcommand{\hgb@KeyTerms}{---}
\newcommand{\KeyTerms}[1]{\renewcommand{\hgb@KeyTerms}{#1}}

\newcommand{\hgb@Contact}{}
\newcommand{\Contact}[1]{%
	\renewcommand{\hgb@Contact}{#1}
}

\newcommand{\hgb@Department}{\@MissingArg{Department/Research Group??}}
\newcommand{\Department}[1]{%
	\renewcommand{\hgb@Department}{#1}
}

\newcommand{\hgb@Institution}{\@MissingArg{Institution??}}
\newcommand{\Institution}[1]{%
	\renewcommand{\hgb@Institution}{#1}
}

\newcommand{\hgb@Address}{\@MissingArg{Address??}}
\newcommand{\Address}[1]{%
	\renewcommand{\hgb@Address}{#1}
}

\urldef{\hgb@UrlInstitution}\url{}
\newcommand{\UrlInstitution}[1]{%
	\urldef{\hgb@UrlInstitution}#1
}
\UrlInstitution{\url{www.fh-hagenberg.at}}

\urldef{\hgb@UrlReport}\url{} 
\newcommand{\UrlReport}[1]{%
	\urldef{\hgb@UrlReport}#1
}

\newcommand{\hgb@ReportNumber}{\@MissingArg{Report Number??}}
\newcommand{\ReportNumber}[1]{%
	\renewcommand{\hgb@ReportNumber}{#1}
}

%% Logo -------------------------------------------------------

\newcommand{\hgb@Logo}{}
\newcommand{\Logo}[1]{%
	\renewcommand{\hgb@Logo}{#1}
}
\Logo{logo}	% logo.eps is the default logo file

\newlength{\hgb@Logoheight}
\newcommand{\LogoHeight}[1]{%
	\setlength{\hgb@Logoheight}{#1}
}
\LogoHeight{20mm}

\newcommand{\hgb@MakeLogo}{
  \ifthenelse{\equal{\hgb@Logo}{}}%
	{\rule{0pt}{\hgb@Logoheight}}%	empty logo
	{\includegraphics[height=\hgb@Logoheight]{\hgb@Logo}}
}


%% BibTeX-citation ------------------------------------------

\newcommand{\hgb@BibTexKey}{\hgb@ReportNumber}
\newcommand{\hgb@BibTexAuthor}{\@author}
\newcommand{\hgb@BibTexTitle}{\@title}
\newcommand{\hgb@BibTexLanguage}{\hgb@MainLanguage}
\newcommand{\hgb@BibTexInstitution}{\hgb@Department, \hgb@Institution}
\newcommand{\hgb@BibTexAddress}{\hgb@Address}
\newcommand{\hgb@BibTexYear}{\hgb@GetDateYear}
\newcommand{\hgb@BibTexMonth}{\BibTexMonthName{\hgb@GetDateMonth}}
\newcommand{\hgb@BibTexUrl}{{\urlstyle{same}\hgb@UrlReport}}
%\newcommand{\hgb@BibTexNote}{{\urlstyle{same}\hgb@UrlInstitution}}

% these can be used to overwrite the generated fields:
\newcommand{\BibTexKey}[1]{\renewcommand{\hgb@BibTexKey}{#1}}
\newcommand{\BibTexAuthor}[1]{\renewcommand{\hgb@BibTexAuthor}{#1}}
\newcommand{\BibTexTitle}[1]{\renewcommand{\hgb@BibTexTitle}{#1}}
\newcommand{\BibTexLanguage}[1]{\renewcommand{\hgb@BibTexLanguage}{#1}}
\newcommand{\BibTexInstitution}[1]{\renewcommand{\hgb@BibTexInstitution}{#1}}
\newcommand{\BibTexAddress}[1]{\renewcommand{\hgb@BibTexAddress}{#1}}
\newcommand{\BibTexYear}[1]{\renewcommand{\hgb@BibTexYear}{#1}}
\newcommand{\BibTexMonth}[1]{\renewcommand{\hgb@BibTexMonth}{#1}}
\newcommand{\BibTexUrl}[1]{\renewcommand{\hgb@BibTexUrl}{#1}}
%\newcommand{\BibTexNote}[1]{\renewcommand{\hgb@BibTexNote}{#1}}

\newcommand{\BibTexMonthName}[1]{%
\ifcase#1\relax
\or jan%
\or feb%
\or mar%
\or apr%
\or may%
\or jun%
\or jul%
\or aug%
\or sep%
\or oct%
\or nov%
\or dec%
\fi}



\newcommand{\MakePlainReference}{\noindent
%suppress hyphenation because this should be copied from PDF
\begin{minipage}{\textwidth}%
\footnotesize\raggedright\hyphenpenalty=10000
\hgb@BibTexTitle,
\emph{\@title},
\hgb@TechnicalReportName\ \hgb@ReportNumber,
\hgb@BibTexInstitution, \hgb@BibTexAddress, 
%\monthname{\hgb@getdatemonth},
\monthname[\hgb@GetDateMonth]
\hgb@BibTexYear. % ({\tt\hgb@UrlInstitution}).
\urlstyle{tt}\hgb@BibTexUrl
\end{minipage}}

\newcommand{\MakeBibTeXReference}{\noindent
\begin{minipage}{\textwidth}%
\ttfamily\footnotesize\sloppy\raggedright\hyphenpenalty=10000
\begin{list}{}{%
	\setlength{\topsep}{0.3ex}%
	\setlength{\partopsep}{0ex}%
	\setlength{\labelwidth}{3.00cm}%
	\setlength{\leftmargin}{3.25cm}%
	\setlength{\labelsep}{0.25cm}%
	\setlength{\parsep}{0pt}% {0.5 ex plus0.2ex minus0.1ex}%
	\setlength{\itemsep}{0pt}% {0ex plus0.2ex}}
}
\item[@techreport\{\hgb@BibTexKey,\hfill] \relax
\item[author =] \{\hgb@BibTexAuthor\},
\item[title =] \{\hgb@BibTexTitle\},
\item[language =] \{\hgb@BibTexLanguage\},
\item[institution =] \{\hgb@BibTexInstitution\},
\item[address =] \{\hgb@BibTexAddress\},
\item[number =] \{\hgb@ReportNumber\},
\item[year =] \{\hgb@BibTexYear\},
\item[month =] \hgb@BibTexMonth,
\item[url =] \{\hgb@BibTexUrl\}
%\item[note =] \{\hgb@BibTexNote\}
\item[\}\hfill] \relax
\end{list}
\end{minipage}
}


% copyright clause ----------------------------------

\newcommand{\hgb@copyright}{%
Copyright \copyright\ \hgb@GetDateYear\ %\number\the\year\ 
by the authors. This report may be freely used, copied, printed 
and distributed in its entirety on paper or electronically for 
academic purposes. Any copies must include this cover page and 
notice. Any non-academic use is subject to explicit permission 
by the authors.
}

% creating the title pages ----------------------------------

\newcommand{\hgb@ReportTitlePage}{% 
\begin{titlepage}%
\centering
%\vspace*{10mm}
\begin{minipage}[t][7cm][c]{\textwidth} %\centering
	\rule[0pt]{\textwidth}{1mm}
	\vfill
	\begin{center}
		\setlength{\baselineskip}{22pt}
		{\normalfont\LARGE\bf\@title}
		\\[10pt]
  	{\normalfont\normalsize\hgb@ByWord}
		\\[10pt]
  	{\normalfont\large\@author}
  	\\[0pt]
  	{\normalfont\hgb@Contact}
	\end{center}
	\vfill
	\rule[0pt]{\textwidth}{1mm}
\end{minipage}
\\
\vspace{10mm}
  {\sffamily\large \hgb@TechnicalReportName\ \hgb@ReportNumber}
\\[3mm]
  %{\sffamily\large Month=\monthname[\hgb@getdatemonth]\ Day=\hgb@GetDateDay} \\ %\@date
  {\sffamily\large \hgb@DisplayDate} %\@date
\\[10mm]
  \hgb@Department
\\[3mm]
  \hgb@Institution, \hgb@Address
\\[3mm]
  {\urlstyle{sf}\hgb@UrlInstitution}
\\[16mm]
	\hgb@MakeLogo
\\
	\vfill
  \begin{minipage}{\textwidth}\footnotesize
  \begin{english}
  \noindent\hgb@copyright
  \end{english}
  \end{minipage}
%
\end{titlepage}%
}

\newcommand{\hgb@ReportSecondPage}{% 
	\pagenumbering{roman}
	\setcounter{page}{2}
	\thispagestyle{plain}
%
	\begin{center}
	  \bf\abstractname
	\end{center}
%
	\noindent
		\hgb@Abstract\par
  \bigskip\noindent
%	
	\textbf{\hgb@KeywordsName:} \hgb@KeyTerms\relax
%
	\vspace{10mm}
	\vfill
	\begin{center}\bf
	    \hgb@ReferenceName
	\end{center}
		\MakePlainReference\par
	\begin{center}
	\MakeBibTeXReference
	\end{center}
}

\newcommand{\hgb@maketitlepages}{%
	\hgb@ReportTitlePage
  \hgb@ReportSecondPage
	\clearpage
	\pagenumbering{arabic}
	\setcounter{page}{1}
}

\renewcommand{\maketitle}{	%replace standard LaTeX-command
\hgb@maketitlepages
}

%% headers ----------------------------------------------

\RequirePackage{fancyhdr}
\pagestyle{fancy}

\@ifundefined{chapter}%
   {}%
	 {\renewcommand{\chaptermark}[1]{%
			\ifthenelse{\value{chapter} < 1}%
				{\markboth{#1}{}}%
				{\markboth{\thechapter.\ #1}{}}
		}}

\addtolength{\headheight}{\baselineskip}
%\renewcommand{\headrulewidth}{0.4pt} %% Thin header line.
\renewcommand{\headrulewidth}{0pt} %% Thin header line.
\renewcommand{\footrulewidth}{0pt}
\fancyhf{}                            %% Clear all fields.
%\fancyhead[R]{\sffamily\thepage} %{\bf \rightmark}
%\fancyhead[L]{\sffamily\nouppercase{\leftmark}}  %{\slshape \leftmark}
%\fancyhead[L]{\sffamily\nouppercase{\hgb@ReportNumber}}  %{\slshape \leftmark}

% define page header contents for both formats
\ifthenelse{\boolean{hgb@reportHasChapters}}%
	%chapters:
   {\fancyhead[R]{\sffamily\thepage}
    \fancyhead[L]{\sffamily\nouppercase{\leftmark}}}%
  %nochapters:
	 {\fancyhead[R]{\sffamily\thepage}
	  \fancyhead[L]{\sffamily\nouppercase{\hgb@Shorttitle}}} %\hgb@ReportNumber

\fancypagestyle{plain}{%
	\fancyhf{} % clear all header and footer fields
	\fancyfoot[C]{\sffamily\thepage} % except the center
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}

%-- hyperref
% Funktioniert grundsätzlich (auch mit dvips setup). 
%Problem: damit URLs über Zeilen umgebrochen werden, muss man
%pdftex verwenden. In diesem Fall sind alle Bilder als pdf-Dateien
%abzuspeichern (bzw. zu konvertieren). 

%\usepackage[breaklinks=true,colorlinks]{hyperref}

%Tobias Viktorin (CMS05025):
%\usepackage[plainpages=false,pdfpagelabels,bookmarks,colorlinks]{hyperref}
%\hypersetup{
%pdftitle = {<<Titel>>},
%pdfsubject = {Bachelorarbeit an der FH Hagenberg},
%pdfauthor = {<<Autor>>, <<Nr.>>},
%pdfcreator = {LaTeX with hyperref},
%pdfproducer = {pdfTeX},
%pdfstartview = {FitV}
%}



\endinput

