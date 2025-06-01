import 'dart:math';
import 'package:flutter/material.dart';
import 'package:adaptive_ticket_view/adaptive_ticket_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Ticket View Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaptive Ticket View Demo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Detailed Flight Ticket',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              AdaptiveTicketView(
                ticketBgColor: const Color(0xffcaf0f8),
                ticketBorderColor: const Color(0xff00b4d8),
                lineStyle: TicketLineStyle.dotted,
                lineColor: const Color(0xff0077b6),
                ticketInfoWidget: Column(
                  children: [
                    Transform.rotate(
                      angle: pi / 4,
                      child: const Icon(
                        Icons.flight,
                        size: 45,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      "Wings of Wanderlust: Your Ticket to Adventure",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      "Embark on a journey of a lifetime! Your wings await as you soar through the skies towards unforgettable destinations. Buckle up and let your adventure begin with this ticket to new horizons. Safe travels and enjoy the wonders that lie ahead!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: const Color(0xff0077b6),
                        ),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("New York"),
                                Text("NYC"),
                                Text("10:00 AM"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Duration",
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "13H 30M",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("London"),
                                Text("LDN"),
                                Text("11:30 PM"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ticketBottomMessage:
                    "May your flight be smooth, your adventures be thrilling, and your memories be everlasting!",
                ticketCode: "12132334MCFHGADH",
              ),
              const SizedBox(height: 24),
              const Text(
                'Dotted Line Style',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              AdaptiveTicketView(
                ticketBgColor: Colors.blue[100]!,
                ticketBorderColor: Colors.blue,
                lineStyle: TicketLineStyle.dotted,
                lineColor: Colors.blue,
                ticketInfoWidget: _buildTicketContent(),
                ticketBottomMessage: "Enjoy your journey!",
                ticketCode: "123456789",
              ),
              const SizedBox(height: 24),
              const Text(
                'Solid Line Style',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              AdaptiveTicketView(
                ticketBgColor: Colors.green[100]!,
                ticketBorderColor: Colors.green,
                lineStyle: TicketLineStyle.solid,
                lineColor: Colors.green,
                ticketInfoWidget: _buildTicketContent(),
                ticketBottomMessage: "Have a great day!",
                ticketCode: "987654321",
              ),
              const SizedBox(height: 24),
              const Text(
                'No Line Style',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              AdaptiveTicketView(
                ticketBgColor: Colors.purple[100]!,
                ticketBorderColor: Colors.purple,
                lineStyle: TicketLineStyle.none,
                ticketInfoWidget: _buildTicketContent(),
                ticketBottomMessage: "Thank you for choosing us!",
                ticketCode: "456789123",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Flight Details",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildInfoRow("From", "New York"),
        _buildInfoRow("To", "London"),
        _buildInfoRow("Date", "March 15, 2024"),
        _buildInfoRow("Time", "10:00 AM"),
        _buildInfoRow("Flight", "BA 123"),
        _buildInfoRow("Gate", "A12"),
        _buildInfoRow("Seat", "23A"),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
