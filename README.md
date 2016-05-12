# Diff Config

Tool for diffing a large number of configuration files. Currently supports `.yaml`, `.conf`, and `.properties` files shipped with DSE.

## Sample Disk layout
The following is the disk layout I use. It is possible to use many other layouts since the logic simply globs through the
target directory.

```none
+ configs                   # Home to configurations which are considered accurate.
| + DEV                     # Environment identifier
| | + cassandra.yaml        # Sample configuration file
| | + spark-defaults.conf
| + default                 # Default configuration files for comparing with. This may be omitted.
+ test_configs              # Directory of configurations to test
  + DEV                     # Environment identifier, this directory may be omitted
  | + HOSTNAME              # Hostname identifier, this directory may be omitted.
  | | + cassandra.yaml      # Sample configuration file
  | | + spark-defaults.conf
  | | + ...
  | + HOSTNAME2
  |   + ...
  + SIT
    + ...
```

## Usage

```fish
➜  diff_config -h
Usage: diff_config [options]
    -s, --source SOURCE
    -t, --targets TARGETS
    -w, --whitelist KEYS
```

* **source:** Source configuration file to compare against
* **targets:** Target configuration files to test. This is used as a glob. Feel free to use `**` in a path to test many directories.
* **whitelist:** Comma-separated set of keys to whitelist. These keys will **NEVER** appear in the diff output.

## Sample Commands

**Compare a directory full of configs from many servers**

```
diff_config -s 'configs/DEV/cassandra.yaml' -t 'test_configs/DEV/**/cassandra.yaml' -w rpc_address,listen_address
diff_config -s 'configs/DEV/cassandra-rackdc.properties' -t 'test_configs/DEV/**/cassandra-rackdc.properties'
diff_config -s 'configs/DEV/spark-defaults.conf' -t 'test_configs/DEV/**/spark-defaults.conf'
```

**Compare a single pair of configs**

```
diff_config -s 'configs/DEV/cassandra.yaml' -t 'test_configs/DEV/foo/cassandra.yaml' -w rpc_address,listen_address
diff_config -s 'configs/DEV/cassandra-rackdc.properties' -t 'test_configs/DEV/foo/cassandra-rackdc.properties'
diff_config -s 'configs/DEV/spark-defaults.conf' -t 'test_configs/DEV/foo/spark-defaults.conf'
```

## Other approaches
Some files may not be loaded and compared in the manner we use for diff_config. It may also be faster to simply see if the files match (eg cassandra-env.sh). In this case we use the `md5` (`md5sum` in some distributions) to generate a hash of the file. If the hash of two files match then the two files are **extremely** likely to be the same. Look for files with different hashes to investigate further.

```
md5 configs/DEV/cassandra-env.sh
md5 test_configs/DEV/**/cassandra-env.sh

md5 configs/DEV/spark-env.sh
md5 test_configs/DEV/**/spark-env.sh
```
