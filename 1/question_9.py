import numpy as np
import pandas as pd


class Doctor:
    def __init__(self):
        self.next_available = 0

    def see_patient(self, start_time, patient):
        self.next_available = start_time + patient.treatment_time


class Patient:
    def __init__(self, arrival_time):
        self.arrival_time = arrival_time
        self.treatment_time = np.random.uniform(5, 20)

    def see_doctor(self, start_time):
        self.start_time = start_time

    def __getitem__(self, item_name):
        self.attributes = {
            'arrival_time': self.arrival_time,
            'start_time': self.start_time,
            'waiting_time': self.start_time - self.arrival_time,
            'finish_time': self.start_time + self.treatment_time
        }
        return self.attributes[item_name]


def gen_arrival_times(max_time=420):
    time = np.random.exponential(10)
    while time < max_time:
        yield time
        time += np.random.exponential(10)


def process_patients(arrival_times):
    drs = [Doctor() for _ in range(3)]
    patients = [Patient(at) for at in arrival_times]
    for patient in patients:
        first_available_dr = sorted(drs, key=lambda x: x.next_available)[0]
        start_time = max(
            patient.arrival_time,
            first_available_dr.next_available
        )
        first_available_dr.see_patient(start_time, patient)
        patient.see_doctor(start_time)
    return drs, patients


def simulate_day():
    # get arrival times of patients throughout the day
    arrival_times = [t for t in gen_arrival_times()]
    drs, patients = process_patients(arrival_times)
    waited = [p for p in patients if p['waiting_time'] > 0]
    return [
        len(patients),
        len(waited),
        np.mean([p['waiting_time'] for p in waited]) if waited else 0,
        max(
            sorted(drs, key=lambda x: x.next_available)[-1].next_available,
            420
        )
    ]


def simulate_days(n=100):
    days = np.concatenate([simulate_day() for _ in range(n)]).reshape(-1, 4)
    return pd.DataFrame(
        days,
        columns=[
            'patient_count',
            'waited_count',
            'mean_waiting_time',
            'closing_time'
        ]
    )


def summarise(a):
    median = np.median(a)
    fifty_percent_interval = (np.percentile(a, 25), np.percentile(a, 75))
    return median, fifty_percent_interval


if __name__ == "__main__":
    simulations = simulate_days()
    print(
        "Number of patients:\n",
        "{}, {}".format(*summarise(simulations['patient_count']))
    )
    print(
        "Number waited:\n",
        "{}, {}".format(*summarise(simulations['waited_count']))
    )
    print(
        "Average waiting time:\n",
        "{}, {}".format(*summarise(simulations['mean_waiting_time']))
    )
    print(
        "Closing time:\n",
        "{}, {}".format(*summarise(simulations['closing_time']))
    )
