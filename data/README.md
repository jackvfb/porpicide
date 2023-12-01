# Description of Data Files

## `raw/`
* `'Bee_TMMC Harbor Porpoises 2007-2016.xlsx'`

  These are the trauma cases during the time period 2007-2016 were reviewed by Bee Chandra to investigate likelihood of porpicide. Bee reviewed the TME data for each trauma case to identify the presence or absence of Rake Marks, Hemorrhages, and Fractures (See the "Trauma" sheet, where the slashes indicate the presence of each type of trauma).

* `'Duignan_HarborPorpoiseNecropsies_Jan2007_Jun2016.xlsx'`

    Complete record of harbor porpoise necropsies from 2007 - 2016, the time period over which Bee Chandra conducted her review of trauma cases.

* `'TMMC HarborPorpoiseStrandings Jul 2016-Oct 2023_Level A_COD_TME.xlsx'`

    These are the cases of harbor porpoise strandings from the time since Bee completed her project to the present. The cases were all reviewed by Padraig D. and classified into four categories to estimate the probability of porpicide: Confirmed, Probable, Suspect, Unlikely.
  
    + Confirmed Case: Tt rakes + Fractures + Hemorrhage +/- Capture Myopathy
    + Probable Case: Fractures + Hemorrhage +/- Capture Myopathy
    + Suspect Case: Hemorrhage +/- Capture Myopathy
    + Unlikely Case: Sudden death without blunt or sharp force trauma.

## `/derived`

* `'Porpicide_Lookup.csv'`

This is a derived data file that lists the likelihood of porpicide associated with each case. The likelihoods were taken from annotations in the raw data files above.

When using the label's in Bee's data to classify the probability, I used the following key:


|	Bee's data			|  My classification	|
| ------------------------------------- | --------------------- |
| Rake marks, hemorrhages, and fractures| Confirmed	  	|
| Rake marks and hemorrhages		| Probable	  	|
| Rake marks and fractures		| Probable	  	|
| Hemorrhages only			| Suspect	  	|
| None/Non-trauma case			| Unlikely		|

Note: Both PD and BC reviewed C-503 and C-511. PD's classification was used for these cases

