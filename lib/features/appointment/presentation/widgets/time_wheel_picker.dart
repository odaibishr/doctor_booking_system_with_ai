import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class TimeWheelPicker extends StatefulWidget {
  final int initialHour;
  final int initialMinute;
  final bool initialIsAm;
  final String availableRange;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const TimeWheelPicker({
    super.key,
    this.initialHour = 7,
    this.initialMinute = 30,
    this.initialIsAm = true,
    this.availableRange = '',
    required this.onTimeChanged,
  });

  @override
  State<TimeWheelPicker> createState() => _TimeWheelPickerState();
}

class _TimeWheelPickerState extends State<TimeWheelPicker> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _amPmController;

  late int _selectedHour;
  late int _selectedMinute;
  late bool _isAm;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.initialHour;
    _selectedMinute = widget.initialMinute;
    _isAm = widget.initialIsAm;

    _hourController = FixedExtentScrollController(
      initialItem: _selectedHour - 1,
    );
    _minuteController = FixedExtentScrollController(
      initialItem: _selectedMinute,
    );
    _amPmController = FixedExtentScrollController(initialItem: _isAm ? 0 : 1);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _amPmController.dispose();
    super.dispose();
  }

  void _notifyChange() {
    final hour24 = _isAm
        ? (_selectedHour == 12 ? 0 : _selectedHour)
        : (_selectedHour == 12 ? 12 : _selectedHour + 12);
    widget.onTimeChanged(TimeOfDay(hour: hour24, minute: _selectedMinute));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'وقت التنفيذ',
          style: FontStyles.headLine4.copyWith(
            color: const Color(0xFFD42D5A),
            fontWeight: FontWeight.bold,
          ),
        ),
        if (widget.availableRange.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            widget.availableRange,
            style: FontStyles.body1.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 20),
        _buildColumnHeaders(),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: Row(
            children: [
              Expanded(child: _buildAmPmWheel()),
              _buildDivider(),
              Expanded(child: _buildMinuteWheel()),
              _buildDivider(),
              Expanded(child: _buildHourWheel()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColumnHeaders() {
    return Row(
      children: [
        Expanded(child: _headerChip('ص/م')),
        const SizedBox(width: 8),
        Expanded(child: _headerChip('دقيقة')),
        const SizedBox(width: 8),
        Expanded(child: _headerChip('ساعة')),
      ],
    );
  }

  Widget _headerChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFD42D5A),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: FontStyles.subTitle3.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 120, color: Colors.white12);
  }

  Widget _buildHourWheel() {
    return ListWheelScrollView.useDelegate(
      controller: _hourController,
      itemExtent: 50,
      perspective: 0.003,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) {
        setState(() => _selectedHour = index + 1);
        _notifyChange();
      },
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: 12,
        builder: (context, index) {
          final hour = index + 1;
          final isSelected = hour == _selectedHour;
          return Center(
            child: Text(
              '$hour',
              style: TextStyle(
                fontSize: isSelected ? 28 : 20,
                color: isSelected ? const Color(0xFFD42D5A) : Colors.white54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMinuteWheel() {
    return ListWheelScrollView.useDelegate(
      controller: _minuteController,
      itemExtent: 50,
      perspective: 0.003,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) {
        setState(() => _selectedMinute = index);
        _notifyChange();
      },
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: 60,
        builder: (context, index) {
          final isSelected = index == _selectedMinute;
          return Center(
            child: Text(
              '$index'.padLeft(2, '0'),
              style: TextStyle(
                fontSize: isSelected ? 28 : 20,
                color: isSelected ? const Color(0xFFD42D5A) : Colors.white54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAmPmWheel() {
    final items = ['ص', 'م'];
    return ListWheelScrollView.useDelegate(
      controller: _amPmController,
      itemExtent: 50,
      perspective: 0.003,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) {
        setState(() => _isAm = index == 0);
        _notifyChange();
      },
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: items.length,
        builder: (context, index) {
          final isSelected = (_isAm && index == 0) || (!_isAm && index == 1);
          return Center(
            child: Text(
              items[index],
              style: TextStyle(
                fontSize: isSelected ? 28 : 20,
                color: isSelected ? const Color(0xFFD42D5A) : Colors.white54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }
}
