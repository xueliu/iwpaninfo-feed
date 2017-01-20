# iwpaninfo-feed
OpenWRT/LEDE feed for iwpaninfo package

## Table of Contents

- [Install](#install)
- [Test](#test)
- [TODO](#todo)
- [Contribute](#contribute)
- [License](#license)

## Install

Edit your feeds.conf and add the following to it:

    # iwpaninfo
    src-git iwpaninfo https://github.com/xueliu/iwpaninfo-feed

Update your build environment and install the package:

    $ scripts/feeds update iwpaninfo
    $ scripts/feeds install iwpaninfo
    $ make menuconfig

Go to Utilities, select iwpaninfo;
Go to Languages --> Lua, select libiwpaninfo-lua;

Exit, save and build

    $ make package/iwpaninfo/compile
    $ make package/iwpaninfo/install

## Test
Lua test scripts are located in example folder.

## TODO
- [ ] support all attributes of nl802154
- [ ] Lua bindings
- [ ] More tests

## Contribute

Found a bug? Please create an issue on GitHub:
    https://github.com/xueliu/iwpaninfo-feed/issues

Further tests and PR's are welcome and appreciated.

## License

GPLv2
