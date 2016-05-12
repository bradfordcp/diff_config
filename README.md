# Diff Config

Tool for diffing a large number of configuration files. Currently supports .yaml, .conf, and .properties files shipped with DSE.

## Sample Disk layout
The following is the disk layout I use. It is possible to use many other layouts since the logic simply globs through the
target directory.

```
+ configs                 # Home to configurations which are considered accurate. These will be the base configs to compare against.
+ test_configs            # Directory of configurations to test
  + DEV                   # Environment identifier, this is **NOT** required.
    + HOSTNAME            # Hostname identifier to allow for syncing of configurations later
      + cassandra.yaml    # Sample configuration file
      + cassandra-env.sh
      + ...
    + HOSTNAME2
      + ...
  + SIT
    + ...
+
```

## Usage

```
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

```
diff_config -s 'configs/DEV/address.yaml' -t 'test_configs/DEV/**/address.yaml'
diff_config -s 'configs/DEV/cassandra.yaml' -t 'test_configs/DEV/**/cassandra.yaml' -w rpc_address,listen_address
diff_config -s 'configs/DEV/cassandra-rackdc.properties' -t 'test_configs/DEV/**/cassandra-rackdc.properties'
diff_config -s 'configs/DEV/dse.yaml' -t 'test_configs/DEV/**/dse.yaml'
diff_config -s 'configs/DEV/spark-defaults.conf' -t 'test_configs/DEV/**/spark-defaults.conf'
```

*MD5 used for files which cannot be directly compared. Look for differing hashes*

```
md5 configs/DEV/cassandra-env.sh
md5 test_configs/DEV/**/cassandra-env.sh

md5 configs/DEV/spark-env.sh
md5 test_configs/DEV/**/spark-env.sh
```
