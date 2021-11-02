# *Code Repository of the Article* <br/>Quantifying observer metamerism of LED spectra which chromatically mimic natural daylight

This repository provides a function to calculate the observer metamerism effect of two spectra which are metameric for the reference observer  as presented in the article *"Quantifying observer metamerism of LED spectra which chromatically mimic natural daylight"* authored by Adrian Eissfeldt, Babak Zandi, Alexander Herzog and Tran Quoc Khanh. <br/>

<div align="center">
<a style="font-weight:bold" href="https://doi.org/10.1364/OE.433411">[Paper]</a>
<a style="font-weight:bold" href="https://doi.org/10.6084/m9.figshare.16743736">[Supplementary materials]</a>
</div> <br/>

## Code

To calculate the average chromaticity error `deltaOM` with the proposed deviate observer functions, call the function [`getObserverMetamerismError.m`](getObserverMetamerismError.m) with two spectra which are metameric for the reference observer at a `fieldsize` of 2° or 10°. `deltaOM` corresponds to the average CIE 1976 u'v' chromaticity difference of individual observers. While the deviate observer functions are ranging from 390 nm to 780 nm (with a 5 nm interval), you can set `interpolate` to 1 in order to use this function also with spectra ranging from 380 nm to 780 nm and a 1 nm interval.

```matlab
deltaOM = getObserverMetamerismError(spectrum_1, spectrum_2, fieldsize, interpolate);
```

The Matlab script [`main.m`](main.m) provides a simple demo code for using this function with a daylight-spectrum and a LED-spectrum.

## Citation

Please consider to cite our work if you find this repository or our results useful for your research:

Eissfeldt, A.; Zandi, B.; Herzog, A.; Khanh, T.Q. Quantifying observer metamerism of LED spectra which chromatically mimic natural daylight. Opt. Express **29**(13), 38168-38184 (2021). https://doi.org/10.1364/OE.433411

```bib
@article{Eissfeldt:21,
author = {Adrian Eissfeldt and Babak Zandi and Alexander Herzog and Tran Quoc Khanh},
journal = {Opt. Express},
number = {23},
pages = {38168--38184},
publisher = {OSA},
title = {Quantifying observer metamerism of LED spectra which chromatically mimic natural daylight},
volume = {29},
month = {Nov},
year = {2021},
url = {http://www.osapublishing.org/oe/abstract.cfm?URI=oe-29-23-38168},
doi = {10.1364/OE.433411},
}
```

