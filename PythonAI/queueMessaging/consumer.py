import pika

params = pika.URLParameters('amqps://jcjuueuk:YgdVAqQkaln9sXpkh9BFMgZfe3PGDE2H@sparrow.rmq.cloudamqp.com/jcjuueuk')

connection = pika.BlockingConnection(params)

channel = connection.channel()
channel.queue_declare(queue='licencePlate')

def callBack(ch, method, properties, body):
    print("Received in PythonAI " + body.decode())

channel.basic_consume(queue="licencePlate", on_message_callback=callBack, auto_ack=True)
print("Python AI started consuming")

channel.start_consuming()

channel.close()