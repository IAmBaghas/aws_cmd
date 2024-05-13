import os
import subprocess

# Function to read temperature from sensor
def read_temperature():
    # Your code to read temperature goes here
    temperature = 25.0  # This is just a placeholder
    return temperature

# Function to publish temperature to AWS IoT Core
def publish_temperature(temperature):
    command = f'mosquitto_pub -h <your-endpoint>.iot.<region>.amazonaws.com -p 8883 --cafile <path-to-rootCA.pem> --cert <path-to-certificate.pem.crt> --key <path-to-private.pem.key> -t <your-topic> -m "{temperature}"'
    os.system(command)

# Main function
def main():
    temperature = read_temperature()
    publish_temperature(temperature)

if __name__ == "__main__":
    main()



:loop
mosquitto_pub -h <your-endpoint>.iot.<region>.amazonaws.com -p 8883 --cafile <path-to-rootCA.pem> --cert <path-to-certificate.pem.crt> --key <path-to-private.pem.key> -t <your-topic> -f sensor_data.json
timeout /t 10
goto loop
