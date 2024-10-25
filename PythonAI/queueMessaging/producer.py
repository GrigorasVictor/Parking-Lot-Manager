import pika

params = pika.URLParameters('amqps://jcjuueuk:YgdVAqQkaln9sXpkh9BFMgZfe3PGDE2H@sparrow.rmq.cloudamqp.com/jcjuueuk')

connection = pika.BlockingConnection(params)

channel = connection.channel()

def publish(method, body):
    channel.basic_publish(exchange='', routing_key='licencePlate', body='test')