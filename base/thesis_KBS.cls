% class options:
% - select either [german] or [english]
% - select the type of thesis from:
%   [bachelor, master, generic, diss]
%   (in case of generic, use \type{} to specify it)
%   (dissertation so far in German only)
% - use option "alpha" for abbreviated citation (instead of numbers)
% - option "draft" is available, too
% - use options "utf8" or "latin1" to select inputencoding
% - use option "coffee" for fun
\ProvidesClass{base/thesis_KBS}

\LoadClass[11pt,a4paper,twoside,openright]{report}

\newcommand{\setdraft}{}
\DeclareOption{draft}{\renewcommand{\setdraft}{draft}}

\newcounter{sprache}
\setcounter{sprache}{-1}
\DeclareOption{german}{
  \setcounter{sprache}{1}
  \def\@dept{Institut für Informatik\\AG Wissensbasierte Systeme}
  \def\@deptOther{Institut für Kognitionswissenschaften}
  \def\@type{Masterarbeit}
}
\DeclareOption{english}{
  \setcounter{sprache}{2}
  \def\@dept{Institute for Computer Science\\Knowledge-Based Systems}
  \def\@deptOther{Institute of Cognitive Science}
  \def\@type{Master's Thesis}
}

\newcounter{mytype}
\setcounter{mytype}{-1}
\DeclareOption{bachelor}{\setcounter{mytype}{1}}
\DeclareOption{master}{\setcounter{mytype}{2}}
\DeclareOption{generic}{\setcounter{mytype}{0}}
\DeclareOption{diss}{\setcounter{mytype}{3}}

%

\newcounter{encoding}
\setcounter{encoding}{0}
\DeclareOption{latin1}{
	\setcounter{encoding}{1}
}
\DeclareOption{utf8}{
	\setcounter{encoding}{2}
}

\newcounter{bstyle}
\setcounter{bstyle}{1}
\DeclareOption{alpha}{
  \setcounter{bstyle}{2}
}

\ProcessOptions


\RequirePackage{ifthen}

\ifthenelse{\value{encoding} = 1} { % encoding is latin1
	\usepackage[latin1]{inputenc}
	\RequirePackage[T1]{fontenc}
}{
	\ifthenelse{\value{encoding} = 2} { % encoding is utf-8
		\usepackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
	}{}
}


\def\type#1{\gdef\@type{#1}}
\def\dept#1{\gdef\@dept{#1}}
\def\signline#1{\gdef\@signline{#1}}
\def\signcity#1{\gdef\@signcity{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}
\def\@title{}
\def\@author{}
\def\@signcity{Osnabrück}



\ifthenelse{\value{sprache} = 1} { % -> german
	\RequirePackage[ngerman]{babel}
  \RequirePackage{bibgerm} % needed when using {gerplain} style

  \ifthenelse{\value{bstyle} = 1}{
    %\bibliographystyle{gerplain} % setzt Vornamen inkonsistent !!!!!!!
    \bibliographystyle{base/plaindin} 
  }{
    % \bibliographystyle{geralpha} % dito
    \bibliographystyle{base/alphadin}
  }

  \ifthenelse{\value{mytype} = 1}{\type{Bachelorarbeit}}%
             {\ifthenelse{\value{mytype} = 2}{\type{Masterarbeit}}
               {\ifthenelse{\value{mytype} = 3}{\type{Dissertation}}
                 {\type{*** Use \texttt{\textbackslash type\{\}} command to set the type ***}}}}
  
}{ % else -> english
  \RequirePackage[english]{babel}
  \ifthenelse{\value{bstyle} = 1}{
    \bibliographystyle{alpha}
  }{
    \bibliographystyle{alpha}
  }

  \ifthenelse{\value{mytype} = 1}{\type{Bachelor's thesis}}%
             {\ifthenelse{\value{mytype} = 2}{\type{Master's thesis}}
               {\type{*** Use \texttt{\textbackslash type\{\}} command to set the type ***}}}
}

% Page layout in LaTeX
% http://www.ctan.org/tex-archive/macros/latex/contrib/fancyhdr/
\RequirePackage{fancyhdr}

\RequirePackage{lmodern}

% The "extended" or "enhanced" graphics package.
% http://mirror.ctan.org/macros/latex/required/graphics/grfguide.pdf
\RequirePackage[\setdraft]{graphicx}
\graphicspath{{pics/}{base/}}

%\RequirePackage{bbm}

% 'American Mathmatical Society'
% http://ftp.uni-erlangen.de/mirrors/CTAN/support/tcltexed/hlp/eng/amsmath.txt
% additional:
% 	- mathmatical symbols
% 	- mathmatical theorems
% 	- mathmatical fonts
\usepackage{amsmath, amssymb, amsthm, amsfonts}

% Hypertext marks in LaTeX
% http://www.ctan.org/tex-archive/macros/latex/contrib/hyperref/
\usepackage[colorlinks=false, unicode=true, pdfborder={0 0 0}]{hyperref}

% natbib used to emulate the cite package,
% which does NOT work correctly with hyperref
% (though stated otherwise)
%\usepackage[sort&compress, square, comma]{natbib}
%\usepackage[style=alphabetic,natbib=true,backend=biber]{biblatex}
% NOTE: BEST IS WITHOUT ANY OF THESE BUT THE DEFAULT

% Improved citation handling in LaTeX.
% Compatible with both hyperref and backref.
%\RequirePackage[sort]{cite}

% Option "openright" läßt jedes Kapitel auf einer ungeraden Seite starten;
% Problem: ggf. eingefügte Leerseiten haben noch Kopf- und Fußzeilen!!!
% => Lösung:
%
%\makeatletter % nicht notwendig in CLS-Datei
  \def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
  \hbox{}
  \thispagestyle{empty}
  \newpage
  \if@twocolumn\hbox{}\newpage\fi\fi\fi}
%\makeatother % nicht notwendig in CLS-Datei
  
% hilft gegen "nur Grafik"-Seiten:
\renewcommand{\floatpagefraction}{.9} % Default: .5
\renewcommand{\textfraction}{.15}     % Default: .2
\renewcommand{\arraystretch}{1.2}

\headwidth160mm \lhead[\thepage]{\nouppercase{\rightmark}}
\chead{} \rhead[\nouppercase{\leftmark}]{\thepage}
\cfoot{\textsc{\@title}}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}

% Textspiegel
\usepackage{typearea}
\areaset[0.75cm]{16cm}{21cm}
\addtolength{\topmargin}{1cm}
\RequirePackage[bf,small]{caption}


\renewcommand{\O}{{\cal O}}
\renewcommand{\leadsto}{\rightsquigarrow}
\newcommand{\V}[1]{\text{\boldmath $#1$}}    % Format for "Vector"
\newcommand{\M}[1]{\V{#1}}                   % Format for "Matrix"

%\newcommand{\R}{\mathbbm{R}}
%\newcommand{\N}{\mathbbm{N}}
%\newcommand{\C}{\mathbbm{C}}
%\newcommand{\1}{\mathbbm{1}}                 % Einheitsmatrix

\newcommand\pagenumberformatouter{Roman}

% erstellt Liste, bei der alle Eintr"age um <Beispieltext>-Breite einger"uckt sind!
% Parameter: {<Beispieltext>}
\newenvironment{liste}[2][\rm]{\begin{list}{}{\settowidth{\labelwidth}{{#1#2}}
  \setlength{\leftmargin}{\labelwidth}\addtolength{\leftmargin}{\labelsep}
  \addtolength{\leftmargin}{3ex}%
  \setlength{\parsep}{.5ex plus0.2ex minus 0.2ex}%
  \setlength{\itemsep}{1ex}%
  \renewcommand{\makelabel}[1]{{#1##1\hfill}}}}
  {\end{list}}%
%%%%%%%
% liste + "Doppelpunkt" (notwendig, damit Doppenpunkt außerhalb des Stilparameters #1)
\newenvironment{listeDP}[2][\rm]{\begin{list}{}{\settowidth{\labelwidth}{{#1#2}:}
  \setlength{\leftmargin}{\labelwidth}\addtolength{\leftmargin}{\labelsep}
  \addtolength{\leftmargin}{3ex}%
  \setlength{\parsep}{.5ex plus0.2ex minus 0.2ex}%
  \setlength{\itemsep}{1ex}%
  \renewcommand{\makelabel}[1]{{#1##1}:\hfill}}}
  {\end{list}}%
% erstellt BULLET-Liste, bei der alle Eintr"age um <Beispieltext>-Breite einger"uckt sind!
% Parameter: {<Beispieltext>}
\newenvironment{Liste}[2][\rm]{\begin{list}{}{\settowidth{\labelwidth}{\:$\bullet$\: #1#2}
  \setlength{\leftmargin}{\labelwidth}\addtolength{\leftmargin}{\labelsep}
  \addtolength{\leftmargin}{3ex}%
  \setlength{\parsep}{.5ex plus0.2ex minus 0.2ex}%
  \setlength{\itemsep}{1ex}%
  \renewcommand{\makelabel}[1]{\:$\bullet$\, #1##1\hfill}}}
  {\end{list}}%
\newcommand{\grad}{\ensuremath{^{\circ}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifthenelse{\value{sprache} = 1}{
  \usepackage{parskip}
  %\setlength{\parskip}{5pt plus 2pt minus 1pt}
  %\setlength{\parindent}{0pt}
}{}



\ifthenelse{\value{sprache} = 1}{
\def\@submitdate{\ifcase\the\month\or
  Januar\or Februar\or M\"arz\or April\or Mai\or Juni\or
  Juli\or August\or September\or Oktober\or November\or Dezember\fi
  \space \number\the\year}
}{
\def\@submitdate{\ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}
}

\def\@signline{\@signcity, \@submitdate}

\def\firstSupervisor#1{\gdef\@firstSupervisor{#1}}
\def\secondSupervisor#1{\gdef\@secondSupervisor{#1}}
\def\thirdSupervisor#1{\gdef\@thirdSupervisor{#1}}
\thirdSupervisor{???}
\def\email#1{\gdef\@email{#1}}

\newcommand{\generatetitle}{
  \pagenumbering{\pagenumberformatouter}
  \pagestyle{plain}
  \thispagestyle{empty}
  \begin{center}
    %
    \begin{figure}
      \begin{center}
        \vspace{4mm}
        \includegraphics[height=1.5cm]{unilogo}
      \end{center}
    \end{figure}
    \vspace{-4mm}
    %
    \LARGE{\textsc{\@dept}}
    %
    \vfill
    \vspace{-2cm}
    \LARGE{\textsc{\@deptOther}}
    %
    \ifthenelse{\value{mytype} = 3}% format a dissertation differently
               {                
                 \vspace{12mm}
                 
                 \huge{\textbf{\@title}}
                 
                 \vspace{8mm}
                 
                 
                 \LARGE{\emph{\@type}}
                 
                 \vspace{4mm}
                 
                 zur Erlangung des Doktorgrades (Dr.~rer.~nat.)\\ des Fachbereichs Mathematik/Informatik\\ der Universität Osnabrück
                 
                 \vspace{12mm}
                 vorgelegt von
                 
                 \Large{\textit{\@author}}
                 
                 \vfill
                 
                 \large{\@submitdate}
                 
                 \vfill
                 
                 \begin{tabular}{ll}
                   \large
                   \ifthenelse{\value{sprache} = 1}{Erstgutachter:}{First supervisor:}
                   & \large \@firstSupervisor\\
                   \large
                   \ifthenelse{\value{sprache} = 1}{Zweitgutachter:}{Second supervisor:}
                   & \large \@secondSupervisor\\
                   \ifthenelse{\value{sprache} = 1}{Drittgutachter:}{Third supervisor:}
                   & \large \@thirdSupervisor
                 \end{tabular}
               }% normal bachelor/master's thesis
               {
                 \vfill
                 
                 \LARGE{\emph{\@type}}
                 
                 \vspace{8mm}
                 
                 \huge{\textbf{\@title}}
                 
                 \vspace{8mm}
                 
                 \LARGE{\@author}
                 
                 \vspace{32mm}

                 \large{\@submitdate}
                 \vfill

                 \begin{tabular}{ll}
                   \large
                   \ifthenelse{\value{sprache} = 1}{Erstgutachter:}{First supervisor:}
                   & \large \@firstSupervisor\\
                   \large
                   \ifthenelse{\value{sprache} = 1}{Zweitgutachter:}{Second supervisor:}
                   & \large \@secondSupervisor
                 \end{tabular}
               }
\end{center}}

\def\closing{ %the clause that you did not cheat
  \ifthenelse{\value{sprache} = 1}{\chapter*{Erklärung}}{\chapter*{Declaration of Authorship}}
  \thispagestyle{empty}


\ifthenelse{\value{sprache} = 1}{
  Hiermit versichere ich, dass ich die vorliegende Arbeit
  selbst\"andig verfasst und keine anderen als die angegebenen
  Quellen und Hilfsmittel benutzt sowie Zitate kenntlich gemacht
  habe.
}{
  I hereby certify that the work presented here is, to the best of my 
  knowledge and belief, original and the result of my own investigations, 
  except as acknowledged, and has not been submitted, either in part or whole,
  for a degree at this or any other university.
  %Hereby I confirm that I wrote this thesis independently and that I have not made use of any
  %other resources or means than those indicated.
}
  
\bigskip\bigskip

\begin{flushright}
\@signline
\end{flushright}
}

\newenvironment{prefacesection}[1]
{
  \thispagestyle{empty}\centerline{\Large{\textbf{#1}}}\medskip
}{}

\newenvironment{acknowledgements}
{
  \thispagestyle{empty}\par\vspace*{\fill}\section*{Acknowledgements}
}{}


\newcommand{\startTextChapters}{
  \cleardoublepage
  \newcounter{outer}\addtocounter{outer}{\value{page}} % save page number
  \pagestyle{fancy}
  \pagenumbering{arabic}
}

\let\oldAppendix\appendix

\renewcommand{\appendix}{
  \cleardoublepage
  \pagenumbering{\pagenumberformatouter}\setcounter{page}{\value{outer}}
  \oldAppendix
}

\typeout{J^^******************************^^J Using Thesis_KBS class, modified 2014-07-02 J^^*****************************^^J}
