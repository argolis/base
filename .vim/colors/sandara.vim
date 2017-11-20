" Vim color file
" Maintainer: Arne Hoffmann <arne@fish.in-berlin.de>
" Last Change: 2017-10-28

hi  clear
let g:colors_name = "sandara"

" normal text
hi Normal          cterm=NONE               ctermfg=Black 
hi Cursor          cterm=NONE               ctermfg=Black           ctermbg=White
hi lCursor         cterm=NONE               ctermfg=NONE            ctermbg=Cyan


" syntax highlighting
hi Comment          cterm=NONE              ctermfg=DarkRed     
hi Constant         cterm=NONE              ctermfg=DarkGreen   
hi Identifier       cterm=NONE              ctermfg=DarkCyan    
hi PreProc          cterm=NONE              ctermfg=DarkMagenta 
hi Special          cterm=NONE              ctermfg=Red
hi Statement        cterm=bold              ctermfg=Blue        
hi Type             cterm=NONE              ctermfg=Blue        


" vim
hi Title            cterm=NONE              ctermfg=DarkMagenta     
hi StatusLine       cterm=bold              ctermfg=Yellow          ctermbg=Blue 
hi StatusLineNC     cterm=bold              ctermfg=Black           ctermbg=Blue 
hi ErrorMsg         cterm=NONE              ctermfg=White           ctermbg=DarkRed  
hi Question         cterm=NONE              ctermfg=DarkGreen       
hi Search           cterm=NONE              ctermfg=NONE            ctermbg=Yellow
hi IncSearch        cterm=NONE                                      ctermbg=Yellow
hi Visual           cterm=NONE                                      ctermbg=LightGrey
hi VisualNOS        cterm=underline,bold    
hi WildMenu         cterm=NONE              ctermfg=Black           ctermbg=Yellow    
hi WarningMsg       cterm=NONE              ctermfg=DarkRed         

hi Directory        cterm=NONE              ctermfg=DarkBlue        
hi ModeMsg          cterm=bold              
hi MoreMsg          cterm=NONE              ctermfg=DarkGreen       
hi NonText          cterm=NONE              ctermfg=Blue            
hi PmenuSel         cterm=NONE              ctermfg=White           ctermbg=DarkBlue  
hi SpecialKey       cterm=NONE              ctermfg=DarkBlue        
hi VertSplit        cterm=reverse           
hi LineNr           cterm=NONE              ctermfg=Red

hi FoldColumn       cterm=NONE              ctermfg=DarkBlue        ctermbg=Grey     
hi Folded           cterm=NONE              ctermfg=DarkBlue        ctermbg=Grey            

hi DiffAdd          cterm=NONE                                      ctermbg=LightBlue       
hi DiffChange       cterm=NONE                                      ctermbg=LightMagenta    
hi DiffDelete       cterm=NONE              ctermfg=Blue            ctermbg=LightCyan 
hi DiffText         cterm=bold                                      ctermbg=Red      

    

" vim: sw=4 ts=4
