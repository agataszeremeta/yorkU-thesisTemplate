%% This is file `yorkUThesisTemplate.cls', a document class for a York University Thesis
%% modified from Dianne Gall's <gall@spookyhill.net> york-thesis.cls 2011 file available at:
%% https://ctan.org/tex-archive/macros/latex/contrib/york-thesis?lang=en .

%% This document class provides the format for a YorkU Thesis, based on the Faculty of Graduate Studies most outline, valid in June 2021.

%% Defining document parameters
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{yorkUThesisTemplate}
[2021/05/31 v1.0 York University (Toronto, Canada) Thesis Class]
\DeclareOption{draft}{
  \PassOptionsToClass{letterpaper,11pt,oneside,onecolumn,draft,openany}{report}}
\DeclareOption{final}{
  \PassOptionsToClass{letterpaper,11pt,oneside,onecolumn,final,openany}{report}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions{draft}  %% Set draft as the default option
\ProcessOptions
\LoadClass{report}

%% Packages Used in Class
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{makeidx}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{titlesec}

%% Renaming Commands
\let\oldquote\quote
\let\oldendquote\endquote
\let\oldquotation\quotation
\let\oldendquotation\endquotation
\let\oldverse\verse
\let\oldendverse\endverse
\let\oldbibliography\bibliography
\let\oldendbibliography\endbibliography
\let\oldprintindex\printindex

%% Defining Document Layout
\geometry{letterpaper,margin=1.0in}

%% Initializing/Defining Variables
\newboolean{hasfigures}\setboolean{hasfigures}{false}
\newboolean{hastables}\setboolean{hastables}{false}
\newboolean{masters}\setboolean{masters}{false}

%% Defining Functions
%\newcommand{\spacing}[1]{\renewcommand{\baselinestretch}{#1}%\large\normalsize}
\def\hugeskip{\vskip 24pt plus 8pt minus 8pt} 
\def\@ifdefined#1#2{\@ifundefined{#1}{}{#2}}

\titleformat{\chapter}[display]
	{\Large\bfseries}
	{\MakeUppercase{\chaptertitlename}\ \thechapter}
	{10pt}
	{\LARGE\uppercase}
\titlespacing{\chapter}
  {0pt}{75pt}{25pt}
  
\titleformat*{\section}{\Large}  
\titlespacing{\section}
  {0pt}{10pt}{10pt}

\titleformat*{\subsection}{\Large}  
\titlespacing{\subsection}
  {0pt}{10pt}{10pt} 

\renewcommand\contentsname{Table of Contents}
\renewcommand\tableofcontents{\chapter*{\LARGE \MakeUppercase{\contentsname}}
\@starttoc{toc}}

\renewcommand\listfigurename{List of Figures} 
\renewcommand\listoffigures{\chapter*{\LARGE \MakeUppercase{\listfigurename}}
\addcontentsline {toc}{chapter}{List of Figures}
\@starttoc{lof}}

\renewcommand\listtablename{List of Tables}
\renewcommand\listoftables{\chapter*{\LARGE \MakeUppercase{\listtablename}}
\addcontentsline{toc}{chapter}{List of Tables}
\@starttoc{lot}}


%% Defining Options for Front Matter
\def\abstractfile#1{\gdef\@abstractfile{#1}}
\def\dedicationfile#1{\gdef\@dedicationfile{#1}}
\def\acknowledgementsfile#1{\gdef\@acknowledgementsfile{#1}}
\def\abbreviationsfile#1{\gdef\@abbreviationsfile{#1}}
\def\title#1{\gdef\@title{#1}}
\def\author#1{\gdef\@author{#1}} 
\def\masterof#1{\gdef\@masterof{#1}}
\def\department#1{\gdef\@department{#1}}
\def\datemonth#1{\gdef\@datemonth{#1}}
\def\dateyear#1{\gdef\@dateyear{#1}}


% Making Front Matter
%% Command for Making the Title Page
\def\makefrontmatter{%
	\singlespace
	\pagestyle{empty}
	\maketitlepage
	\pagenumbering{roman}
	\setcounter{page}{2}	
	\@ifdefined {@abstractfile}{\makeabstract}
	\@ifdefined {@dedicationfile}{\makededication}
	\@ifdefined {@acknowledgementsfile}{\makeacknowledgements}
	% \@ifdefined {@abbreviationsfile}{\makeabbreviations}
	\tableofcontents
  	\ifthenelse{\boolean{hastables}}{\listoftables}{}
  	\clearpage
  	\ifthenelse{\boolean{hasfigures}}{\listoffigures}{}
  	\clearpage
  }
  
\def\maketitlepage{
  \vspace*{.85in}
  \begin{center}
  	\singlespace
    \textbf{\MakeUppercase{\@title}}
    \hugeskip
    \hugeskip
    \hugeskip
    {\bigskip \MakeUppercase{\@author}}
  	\hugeskip \hugeskip \hugeskip \hugeskip 
  	\ifmasters A THESIS \else A DISSERTATION \fi
  	SUBMITTED TO \\
  	THE FACULTY OF GRADUATE STUDIES \\
  	IN PARTIAL FULFILMENT OF THE REQUIREMENTS \\
  	FOR THE DEGREE OF \\
  	\ifmasters MASTER OF \MakeUppercase{\@masterof}
  	\else DOCTOR OF PHILOSOPHY \fi \\
  	\hugeskip \hugeskip
  	GRADUATE PROGRAM IN \MakeUppercase{\@department} \\
  	YORK UNIVERSITY \\
  	TORONTO, ONTARIO \\
  	\hugeskip \hugeskip 
  	\MakeUppercase{\@datemonth} \MakeUppercase{\@dateyear}
  	\hugeskip \hugeskip \hugeskip 
  	$\copyright$\ \MakeUppercase{\@author}, \MakeUppercase{\@dateyear}
  \end{center}
  \newpage}
  
\def\makeabstract{
  \chapter*{Abstract}
  \addcontentsline{toc}{chapter}{Abstract}
  \noindent
  \@input{\@abstractfile}
  \newpage}

\def\makededication{
  \chapter*{Dedication}
  \addcontentsline{toc}{chapter}{Dedication}
  \noindent
  \@input{\@dedicationfile}
  \newpage}
  
\def\makeacknowledgements{
  \chapter*{Acknowledgements}
  \addcontentsline{toc}{chapter}{Acknowledgements}
  \noindent
  \@input{\@acknowledgementsfile}
  \newpage}
   
\def\makeabbreviations{
  \chapter*{Abbreviations}
  \addcontentsline{toc}{chapter}{Abbreviations}
  \noindent
  \@input{\@abbreviationsfile}
  \newpage}
  
\def\formatmainmatter{	
	\normalsize
	\flushleft
	\onehalfspacing
	\setlength{\parindent}{33pt}
	\setlength{\parskip}{11pt}
	\pagenumbering{arabic}
	\setcounter{page}{1}
	}
  
%% End of file `yorkUThesisTemplate.cls'.

