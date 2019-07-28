#!/usr/bin/env python3

import sys
import shutil

import numpy as np
import skimage.transform as skt

import pydicom

def usage():
    print("Usage: {} input.dcm output.dcm scalefactor".format(sys.argv[0]))

def printminmax(x):
    xmin = x.min()
    xmax = x.max()
    print("minmax: {}, {}".format(xmin, xmax))

def main():

    if len(sys.argv) != 4:
        ecode = 0
        if len(sys.argv) != 1:
            ecode = -1
            print("Error, expect exactly 3 arguments.")
        usage()
        sys.exit(ecode)

    infile = sys.argv[1]
    outfile = sys.argv[2]
    scalefactor = float(sys.argv[3])

    try:
        shutil.copyfile(infile, outfile)
    except (SameFileError, OSError) as err:
        print("Failed to create output file: {}".format(err))
        sys.exit(-1)

    dataset = pydicom.dcmread(outfile)
    data = dataset.pixel_array
    printminmax(data)
    oldtype = data.dtype
    data = skt.resize(data, [int(i/scalefactor) for i in data.shape], order=1,
                      preserve_range=True)
    printminmax(data)
    dataset.PixelData = data.astype(oldtype).tobytes()
    dataset.Rows, dataset.Columns, dataset.NumberOfFrames = data.shape
    printminmax(dataset.pixel_array)

    dataset.save_as(outfile)

if __name__ == "__main__":
    main()                                                                                                                         
