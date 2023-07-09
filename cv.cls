\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[My custom CV class]

\LoadClass{article} % default article style

% packages
\RequirePackage[a4paper, margin=0.75cm]{geometry} % Adjust page margins
\RequirePackage{titlesec}
\RequirePackage{enumitem} % Required for customizing list spacing
\RequirePackage{float}
\RequirePackage{hyperref}



% title
\titleformat{\section}         % Customise the \section command 
  {\Large\scshape\raggedright} % Make the \section headers large (\Large),
                               % small capitals (\scshape) and left aligned (\raggedright)
  {}{0em}                      % Can be used to give a prefix to all sections, like 'Section ...'
  {}                           % Can be used to insert code before the heading
  [\titlerule\vspace{-0.7\baselineskip}] % Inserts a horizontal line after the heading and reduces the vertical spacing

\titlespacing{\section}
  {0pt} % left spacing
  {0.5\baselineskip} % vertical spacing before section
  {0.5\baselineskip} % vertical spacing after section

\newcommand{\centeredheader}[5]{ % Define the centeredheader command with four arguments
  \begin{center}
  \huge\scshape \textbf{#1} \\
  \large #2 \\
  \ #3 \textbar{} \href{mailto:#4}{\textnormal{\texttt{#4}}} \\
  \small \href{#5}{\textnormal{#5}}
  \end{center}
}

% double title list
\newcommand{\dtList}[5]{%
    \begin{tabular}[t]{@{}l@{}}
        #1 -- \\ #2
    \end{tabular} & 
    \begin{tabular}[t]{@{}p{0.9\linewidth}@{}} % Length is set by 0.9\linewidth
        \textbf{#3} #4 \\
        \vspace{-\topsep} % Reduce the vertical space above the itemize environment
        \ifx#5\empty % Check if the fifth parameter is empty
            % No items provided
        \else
            \begin{itemize}[itemsep=0pt, parsep=0pt, topsep=0pt, leftmargin=*] % Customize the itemize environment with reduced spacing
                #5
            \end{itemize}
        \fi
    \end{tabular}
}

% title list
\newcommand{\tList}[4]{%
    \begin{tabular}[t]{@{}l@{}}
        #1 -- \\ #2
    \end{tabular} & 
    \begin{tabular}[t]{@{}p{0.9\linewidth}@{}} % Length is set by 0.9\linewidth
        \textbf{#3} \\
        \vspace{-\topsep} % Reduce the vertical space above the itemize environment
        \begin{itemize}[itemsep=0pt, parsep=0pt, topsep=0pt, leftmargin=*] % Customize the itemize environment with reduced spacing
            #4
        \end{itemize}
    \end{tabular}
}

% skill entry
\newcommand{\skillEntry}[2]{%
    #1 & #2 \\
}


% Licence
% Template created by Nicolas Huber, nicolas.huber2@uzh.ch
%
%    MIT License
%    
%    Permission is hereby granted, free of charge, to any person obtaining a copy
%    of this software and associated documentation files (the "Software"), to deal
%    in the Software without restriction, including without limitation the rights
%    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%    copies of the Software, and to permit persons to whom the Software is
%    furnished to do so, subject to the following conditions:
%    
%    The above copyright notice and this permission notice shall be included in all
%    copies or substantial portions of the Software.
%    
%    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
%    SOFTWARE.