# Web of Trust #


## IPFS

#### To add a file to IPFS and generate hash
```
ipfs add data.txt
````

#### To Read data of an IPFS hash such as one below

```
ipfs cat QmV4ypNX3e3XdTCRTLhDjqXjJRpDf35KKdjNPLbiD3Cr2r
```


## ES Specific Modifications

- Imported Whitelist.sol from Open Zeppelin and modified functions within it to be private. This is only the case when importing into WOT.sol , the published Whitelist contract functions are not private.
- Note hardcoded Whitelist Contract value. Please update this to match your published Whitelist address store contract
