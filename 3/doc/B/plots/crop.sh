#!/bin/bash
find . -name "*.pdf" -exec pdfcrop --hires --margins "2 0 0 11" {} {} \;
