# Slurm 23.11.4

Features:

- [Slurm batch scheduler](https://slurm.schedmd.com/) version 23.11.4
- A Cluster `mycluster` with two queues/partitions: `mypartition` and `otherpartition`.
- SSH access for user `xenon` with password `javagat`

## Run

```bash
docker run --cgroupns=host --privileged --cap-add=sys_admin --tmpfs /run \
        --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:rw  -p 10022:22 \
        --rm --name slurmtest -d -v $(pwd)/slurm.conf:/etc/slurm/slurm.conf \
        -v $(pwd)/cgroup.conf:/etc/slurm/cgroup.conf --pid=host \
        slurm-hpc:23.11.4 /sbin/init
```

Once the container is running, you can log into it with (password is 'javagat'):

```bash
ssh -p 10022 xenon@localhost
```

You can then submit a job, e.g.:

```bash
srun /bin/hostname
```

Check the status with

```bash
squeue
sacct
```

## Build

```bash
docker build -t slurm:23.11.4 .
```
