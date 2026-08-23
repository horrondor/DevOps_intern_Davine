const Razorpay = require('razorpay');
const crypto = require('crypto');

const createOrder = async (req, res) => {
  try {
    // Development bypass: when RAZORPAY_BYPASS=true and not in production, return a fake order
    if (process.env.RAZORPAY_BYPASS === 'true' && process.env.NODE_ENV !== 'production') {
      const now = Date.now();
      const order = {
        id: `order_${now}`,
        amount: req.body.amount * 100,
        currency: "INR",
        status: "created",
        receipt: `rcpt_${now}`,
        created_at: Math.floor(now / 1000),
      };
      return res.json(order);
    }

    const instance = new Razorpay({
      key_id: process.env.RAZORPAY_KEY_ID,
      key_secret: process.env.RAZORPAY_KEY_SECRET,
    });
    
    // Razorpay accepts amount in paise
    const options = {
      amount: req.body.amount * 100,
      currency: "INR",
    };
    
    const order = await instance.orders.create(options);
    if (!order) return res.status(500).send("Some error occured");
    res.json(order);
  } catch (error) {
    res.status(500).send(error);
  }
};

const verifyPayment = async (req, res) => {
  try {
    // Development bypass: auto-verify when RAZORPAY_BYPASS=true and not in production
    if (process.env.RAZORPAY_BYPASS === 'true' && process.env.NODE_ENV !== 'production') {
      return res.status(200).json({ message: "Payment verified successfully (bypass mode)" });
    }

    const { razorpay_order_id, razorpay_payment_id, razorpay_signature } = req.body;
    const sign = razorpay_order_id + "|" + razorpay_payment_id;
    const expectedSign = crypto.createHmac("sha256", process.env.RAZORPAY_KEY_SECRET)
      .update(sign.toString())
      .digest("hex");

    if (razorpay_signature === expectedSign) {
      return res.status(200).json({ message: "Payment verified successfully" });
    } else {
      return res.status(400).json({ message: "Invalid signature sent!" });
    }
  } catch (error) {
    res.status(500).send(error);
  }
};

module.exports = { createOrder, verifyPayment };
