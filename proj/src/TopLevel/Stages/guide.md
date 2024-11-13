# Introduction

This document is a guide for the design of the stages in the hardware pipelined MIPS processor.

# Stage Guide

1. Use the common signals for each stage (i.e. `i_CLK`, `i_RST`, `i_WE`, `i_PC`, `o_PC`, `i_PCplus4`, and `o_PCplus4`)

2. Add inputs for the stage specific signals (changes per stage)
See: https://private-user-images.githubusercontent.com/88785126/384028866-8e8d5e84-ca22-462e-8b85-ea1c00c43e8f.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzEzMzIyOTUsIm5iZiI6MTczMTMzMTk5NSwicGF0aCI6Ii84ODc4NTEyNi8zODQwMjg4NjYtOGU4ZDVlODQtY2EyMi00NjJlLThiODUtZWExYzAwYzQzZThmLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDExMTElMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQxMTExVDEzMzMxNVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTMzNzM4ZjA4NDAxYjVhM2ZhMzQyNzIxNTJjYTBlNTc3ZjRiY2NlZWUwZTFhOWZkMGNhNzliMDVkMDM5MTgyMDUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.XG3ua9fePqVvlV9ENBneOm_dfjEvY2qnAtWhg7wU6xU

3. Add passed through signals for the stage specific signals (changes per stage)
In the table, all passed through signals are stages below the chosen to be implemented stage.
See: https://private-user-images.githubusercontent.com/88785126/384028866-8e8d5e84-ca22-462e-8b85-ea1c00c43e8f.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzEzMzIyOTUsIm5iZiI6MTczMTMzMTk5NSwicGF0aCI6Ii84ODc4NTEyNi8zODQwMjg4NjYtOGU4ZDVlODQtY2EyMi00NjJlLThiODUtZWExYzAwYzQzZThmLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDExMTElMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQxMTExVDEzMzMxNVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTMzNzM4ZjA4NDAxYjVhM2ZhMzQyNzIxNTJjYTBlNTc3ZjRiY2NlZWUwZTFhOWZkMGNhNzliMDVkMDM5MTgyMDUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.XG3ua9fePqVvlV9ENBneOm_dfjEvY2qnAtWhg7wU6xU

4. Add inputs from components of the previous stage (changes per stage)

Basically, add the inputs to the stage from the outputs of components from diatgrams of the previous stage.

5. Add inputs from the forwarding unit (changes per stage)

6. Add outputs to components of the next stage (changes per stage)

7. Add "caching" of stage specific signals (changes per stage)

8. Add components contained/operating until the next stage (changes per stage)
