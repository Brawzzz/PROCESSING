class Complex {
  
    double real;   // the real part
    double img;   // the imaginary part

  public Complex() {
        this.real = 0.0;
        this.img = 0.0;
    }

    public Complex(double real, double img) {
        this.real = real;
        this.img = img;
    }

    public Complex mult(Complex b) {
        double real = this.real * b.real - this.img * b.img;
        double img = this.real * b.img + this.img * b.real;
        return new Complex(real, img);
    }
    
    public Complex add(Complex b) {
        double real = this.real + b.real;
        double img = this.img + b.img;
        return new Complex(real, img);
    }
    
    public double mod() {
      double mod = sqrt( (float)( this.real * this.real + this.img * this.img ) );
      return mod;
    }
    
    
    public ArrayList <Complex> sqrt_complex_1(int n){
   
      ArrayList <Complex> roots = new ArrayList <Complex>();
    
      for( int k = 0 ; k < n ; k++){
        
        this.real = cos((2*k*PI) / n);
        this.img = sin((2*k*PI) / n);
        
        Complex root = new Complex(real , img);
        roots.add(root);
        
      }     
      
      return roots;
    }
    
    public Complex sqrt_complex_k_1(Complex b , int n, int k){
        
        this.real = cos(( 2*k*PI) / n);
        this.img = sin(( 2*k*PI) / n);
        
        Complex z = new Complex(real , img);
        
      return z;
  
    }
}
