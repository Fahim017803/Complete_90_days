## Day-02 | Lab-03: Linux Processes & Process States (CPU Spike – Proper Flow)

## Scenario
Server is initially healthy  
Later, CPU suddenly spikes to 100%  
Application becomes slow  

Goal: Learn baseline → create problem → debug like a DevOps engineer.

## Step 1️⃣ Observe baseline system state (NORMAL)
ps aux
- Reason: See what normally runs on the system.
- Understand normal process list.

top
- Reason: Observe normal CPU and memory usage.
- Learn how “healthy” looks.

## Step 2️⃣ Create the incident (Intentional CPU spike)
yes > /dev/null &
- Reason: Simulate a real production bug (infinite loop / runaway script).
- This is the intentional failure for the lab.

## Step 3️⃣ Confirm the problem (LIVE)
top
- Reason: Verify CPU spike is real.
- You should see:
  - %CPU ≈ 100
  - COMMAND = yes
  - STATE = R

## Step 4️⃣ Identify the exact problematic process
ps aux | grep yes
- Reason: Narrow down from system view to exact culprit.
- Answering: WHICH process is causing the issue?

## Step 5️⃣ Understand process state
- R = Running (actively using CPU)
- S = Sleeping (normal)
- D = Uninterruptible sleep (IO wait → dangerous)
- Z = Zombie (parent bug)
- T = Stopped
- Reason: State explains behaviour before taking action.

## Step 6️⃣ Check process hierarchy
pstree -p
- Reason: Understand parent–child relation.
- Prevent accidental killing of important services.

## Step 7️⃣ Take safe action
kill <PID>
- Reason: Graceful shutdown first.

kill -9 <PID>
- Reason: Emergency only if graceful kill fails.

## Step 8️⃣ Verify recovery
top
- Reason: Ensure CPU is back to normal.
- Verification is mandatory.

## Step 9️⃣ Optional secondary check (Memory)
free -h
ps aux --sort=-%mem | head
- Reason: Confirm no memory pressure remains.

## Key Learnings
- Always observe baseline before debugging
- Problems are detected by comparing normal vs abnormal
- CPU spike usually indicates infinite loop
- Safe actions prevent collateral damage

### Advance topic(Real world)
- why this is happened?
- who run it?
- will it cause again?

## DevOps Rule
Baseline → Break → Observe → Fix → Verify  
Never skip baseline.
