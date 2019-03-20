#include <mavros/mavros_plugin.h>
#include <sensor_msgs/FluidPressure.h>

namespace mavros {
namespace extra_plugins {
/**
 * @brief Pressure Sensor plugin.
 *
 * This plugin allows publishing pressure sensor data from Ardupilot FCU to ROS.
 *
 */
class PressureSensorPlugin : public plugin::PluginBase {
public:
	PressureSensorPlugin() : PluginBase(),
		pressure_nh("~pressure")
	{ }

	void initialize(UAS &uas_)
	{
		PluginBase::initialize(uas_);

		pressure_pub = pressure_nh.advertise<sensor_msgs::FluidPressure>("press_abs", 10);
	}

	Subscriptions get_subscriptions()
	{
		return {
			       make_handler(&PressureSensorPlugin::handle_pressure)
		};
	}

private:
	ros::NodeHandle pressure_nh;

	ros::Publisher pressure_pub;

	void handle_pressure(const mavlink::mavlink_message_t *msg, mavlink::common::msg::SCALED_PRESSURE2 &pressure) {
		auto pressure_msg = boost::make_shared<sensor_msgs::FluidPressure>();
		pressure_msg->header.stamp = ros::Time::now();
		pressure_msg->header.frame_id = "/pressure";
		pressure_msg->fluid_pressure = pressure.press_abs;
		pressure_msg->variance = 0;

		pressure_pub.publish(pressure_msg);
	}
};
}	// namespace extra_plugins
}	// namespace mavros

#include <pluginlib/class_list_macros.h>
PLUGINLIB_EXPORT_CLASS(mavros::extra_plugins::PressureSensorPlugin, mavros::plugin::PluginBase)
