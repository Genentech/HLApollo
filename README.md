# HLA-Apollo
HLApollo: A superior transformer model for pan-allelic peptide-MHC-I presentation prediction, with diverse negative coverage, deconvolution and protein language features

TODO: Link Paper Here


docker run -v /workspaces/HLA-Apollo:/home/HLA-Apollo -t hla-apollo /home/HLA-Apollo/HLA-Apollo /home/HLA-Apollo/example.csv /home/HLA-Apollo/example_out.csv


## Model Installation
The model is compiled to run on linux systems, the only dependancy is, libatlas, the specific version used and tested is below.
```
sudo apt-get install libatlas-base-dev=3.10.3-8ubuntu7
```

For non linux systems, a Docker file is contained here for running inference on the model.

```
docker build -t hla-apollo .

```


## Model Usage
The model is provided as a binary called HLA-Apollo.  To use the binary provided,

```
chmod 777 HLA-Apollo
./HLA-Apollo example.csv example_out.csv
```

Running through the docker container is as follows on  Github codespaces:
```
docker run -v /workspaces/HLA-Apollo:/home/HLA-Apollo -t hla-apollo /home/HLA-Apollo/HLA-Apollo /home/HLA-Apollo/example.csv /home/HLA-Apollo/example_out.csv
```
- Note:
  - Replace /workspaces/HLA-Apollo with the absolute file path, not relative, for this checked out repository folder on your system.
  - The rest of the command remains constant unless you want to change the input or output filenames.
  - Make sure new csvs you wish to run are located, or symlinked, inside this repositorys folder. 


## Input File Format
An example input csv file is provided called "example.csv"

The input is required to be a csv file with the following 4 columns,

- allele
    - Description: Name of the MHCI allele for inference
    - Example: A*02:01

- peptide
    - Description: Peptide sequence for inference, lengths should be between 8-12 mers
    - Example: IAKSGTSEFL

- n_flank
    - Description: The 10 Amino Acid sequence before the start of the peptide.  If it is unkown, or is known to be less than 10, pad sequence from the left with '*' charachters
    - Example: REELVKNLGT
    - Example: *****KNLGT
    - Example: **********

- c_flank
    - Description: The 10 Amino Acid sequence after the end of the peptide.  If it is unkown, or is known to be less than 10, pad sequence from the right with '*' charachters
    - Example: NKMTEAQEDG
    - Example: NKMTEA****
    - Example: **********


Additional columns can be included and will be passed to the output csv, but will be ignored.

## Output File Format

The model output is a csv file with the same columns as the input, with the following additional columns,
- invalid_allele
    - Description: True if the row contains an allele that is considered invalid, typically this means the model does not have a lookup psuedo sequence available for that allele, otherwise False is populated
- invalid_aa
    - Description: True if an invalid Amino Acid is found, otherwise False is populated
- invalid_length
    - Description: True if peptide length is outside the expected range
- train_allele
    - Description: True if the input allele exists in the training data used for this model.  If False the allele was not present during training, and results should be considered less accurate, see paper for details.
- peptide_length
    - Description: Length of the peptide
- mhc_pred_0
    - Description: Logit score for the input example, higher numbers indicate more likely binding/presentation.
- mhc_pred_0_rank
    - Description: Percentile Rank for the input example, lower numbers indicate more likely binding/presentation.


