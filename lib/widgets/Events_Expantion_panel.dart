import 'package:flutter/material.dart';
import 'package:todo/Calendar_Events.dart';

import 'calendar_event_item.dart';

class EventsExpantionPanel extends StatefulWidget {
  final bool startExpantionOpened;

  final List<Event> userEvents;
  final String expansionPanelTitle;

  EventsExpantionPanel(
      {required this.startExpantionOpened,
      required this.userEvents,
      required this.expansionPanelTitle});

  @override
  _EventsExpantionPanelState createState() => _EventsExpantionPanelState();
}

class _EventsExpantionPanelState extends State<EventsExpantionPanel> {
  bool _isExpanded = false;

  @override
  void initState() {
    _isExpanded = widget.startExpantionOpened;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Theme.of(context).colorScheme.onError,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ListTile(
              onTap: () {
                setState(() {
                  if (widget.userEvents.isEmpty) {
                    _isExpanded = false;
                  } else {
                    _isExpanded = !_isExpanded;
                  }
                });
              },
              title: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  widget.expansionPanelTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  width: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.userEvents.length.toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      _isExpanded
                          ? Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white70,
                              size: 22,
                            )
                          : Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white70,
                              size: 15,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _isExpanded
              ? Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onError,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        itemBuilder: (context, index) {
                          return CalendarEventItem(widget.userEvents[index]);
                        },
                        itemCount: widget.userEvents.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 15,
                          thickness: 0.9,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
